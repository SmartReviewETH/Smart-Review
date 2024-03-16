// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contract/VotingDAO.sol";

interface SmartToken {
  function transfer(address recipient, uint amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint amount) external returns (bool);
  function balanceOf(address account) external view returns (uint);
}
contract SmartReviewContract  {
    SmartToken internal immutable smts;

    //storage type
    mapping (uint => SmartReview) public SmartReviewsMapping; // id-> SmartReview 
    mapping (uint => Review[]) public ReviewsMapping; // id -> array of Reviews
    uint id_counter_smartReview = 0; // counter for SmartReview id
    enum SmartReveiwPhases {ACTIVE, PAUSED, EXPIRED, PAID}
    enum ReveiwPhases {ACTIVE, ACCEPTED}

    SmartReview[] public AllSmartReviews;
    struct SmartReview {
        address payable[] issuers;
        string ipHash;
        string requirementsHash;
        uint256 deadline;
        SmartReveiwPhases phase;
        uint256 bountyAmount;
        uint256 currentBalance; // initially 0
    }
    struct Review{
        address payable issuer;
        string reviewFileHash;
        ReveiwPhases phase;
    }
    event SmartReviewPublished(address payable[] issuers, string ipHash, string requirementsHash, uint256 deadline);
    event ReviewPublished(uint SmartReviewId, uint ReviewId, address payable issuer, string reviewFileHash);
    
    constructor(address smts_) {
        smts = SmartToken(smts_);
    }


    function getSmartReviewsCount() external view returns(uint256) {
        return AllSmartReviews.length;
    }
    function getSmartReviewById(uint id) external view returns(SmartReview memory) {
        return SmartReviewsMapping[id];
    }
    function getReviewsBySmartReviewId(uint smartReviewId) external view returns(Review[] memory) { 
        return ReviewsMapping[smartReviewId];
    }
    function getReviewsCountBySmartReviewId(uint smartReviewId) external view returns(uint256) { 
        return ReviewsMapping[smartReviewId].length;
    }

    function publishSmartReview(address payable[] calldata issuers, string calldata ipHash, string calldata requirementsHash, uint256 deadline, uint256 bountyAmount) external returns(bool) {  
        SmartReview memory newReview = SmartReview(issuers, ipHash, requirementsHash, deadline, SmartReveiwPhases.PAUSED, bountyAmount, 0);
        SmartReviewsMapping[id_counter_smartReview] = newReview;
        AllSmartReviews.push(newReview);
        id_counter_smartReview++;
        //emit event
        emit SmartReviewPublished(issuers, ipHash, requirementsHash, deadline);
        
        return true;
    }
    function AddBountyToSmartReview(uint256 smartReviewId, uint256 amount) external returns(bool){ 
        // address payable fromAccount = payable(msg.sender);
        // TODO: transfer the bounty amount from the address of the caller to this contract address
        // TODO: check sender's account balance
        require(smts.transfer(address(this), amount),"error");
        SmartReviewsMapping[smartReviewId].currentBalance += amount;
        if(SmartReviewsMapping[smartReviewId].currentBalance >=  SmartReviewsMapping[smartReviewId].bountyAmount){
             SmartReviewsMapping[smartReviewId].phase = SmartReveiwPhases.ACTIVE;
        }
        return true;
    }

    // Check if the reviewer is one of the issuer
    function exists(address payable[] calldata issuers, address payable reviewer) private pure returns (bool) {
        for (uint i = 0; i < issuers.length; i++) {
            if (issuers[i] == reviewer) {
                return true;
            }
        }

        return false;
    }
    function publishReview(string calldata reviewFileHash, uint smartReviewId) external returns (bool){
        // VotingDAO votingDaoInstance = VotingDAO(msg.sender);
        Review memory Reviewobj = Review(payable(msg.sender), reviewFileHash, ReveiwPhases.ACTIVE);
        
        ReviewsMapping[smartReviewId].push(Reviewobj);

        //emit event
        emit ReviewPublished(smartReviewId, ReviewsMapping[smartReviewId].length, payable(msg.sender), reviewFileHash);
        // initiliate a voting proposals
        // votingDaoInstance.createProposal();
        return true;
    }
    
}
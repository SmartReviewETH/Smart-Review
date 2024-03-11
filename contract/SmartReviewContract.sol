// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contract/VotingDAO.sol";

contract SmartReviewContract  {

    mapping (uint => SmartReview) public SmartReviewsMapping; // id-> SmartReview
    mapping (uint => Review[]) public ReviewsMapping; // id -> Reviews
    uint id_counter_smartReview = 0; // counter for SmartReview id
    // uint id_counter_Review = 0; //counter for Reviews is
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
    }
    struct Review{
        address payable issuer;
        string reviewFileHash;
        ReveiwPhases phase;
    }
    event SmartReviewPublished(address payable[] issuers, string ipHash, string requirementsHash, uint256 deadline);
    event ReviewPublished(uint SmartReviewId, uint ReviewId, address payable issuer, string reviewFileHash);

    function getSmartReviewsCount() external view returns(uint256) {
        return AllSmartReviews.length;
    }
    function getSmartReviewById(uint id) external view returns(SmartReview memory) {
        return SmartReviewsMapping[id];
    }
    function getReviewsById(uint smartReviewId) external view returns(Review[] memory) {
        return ReviewsMapping[smartReviewId];
    }

    function publishSmartReview(address payable[] calldata issuers, string calldata ipHash, string calldata requirementsHash, uint256 deadline, uint256 bountyAmount) external returns(bool) {  
        SmartReview memory newReview = SmartReview(issuers, ipHash, requirementsHash, deadline, SmartReveiwPhases.ACTIVE, bountyAmount);
        SmartReviewsMapping[id_counter_smartReview] = newReview;
        AllSmartReviews.push(newReview);
        id_counter_smartReview++;
        //emit event
        emit SmartReviewPublished(issuers, ipHash, requirementsHash, deadline);
        return true;
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
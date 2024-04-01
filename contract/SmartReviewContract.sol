// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SmartReviewContract  {
    IERC20 public smts;
    address public governor;

    //storage type
    mapping (uint => SmartReview) public SmartReviewsMapping; // id-> SmartReview 
    mapping (uint => Review[]) public ReviewsMapping; // id -> array of Reviews

    uint id_counter_smartReview = 0; // counter for SmartReview id
    enum SmartReveiwPhases {ACTIVE, PAUSED, EXPIRED, COMPLETE}
    enum ReveiwPhases {ACTIVE, ACCEPTED}

    SmartReview[] public AllSmartReviews;

    struct SmartReview {
        address payable[] issuers;
        string ipHash;
        string requirementsHash;
        uint256 deadline;
        SmartReveiwPhases phase;
        uint256 bountyAmount; //in Wei
        uint256 currentBalance; // initially 0 in Wei
        string[2] info; // first element in the array is title, second is description
    }
    struct Review{
        address payable issuer;
        string reviewFileHash;
        ReveiwPhases phase;
        string proposal_id; // for storing proposal id
    }
    event SmartReviewPublished(address payable[] issuers, string ipHash, string requirementsHash, uint256 deadline,uint256 bountyAmount,uint256 smartReviewId);
    event ReviewPublished(uint SmartReviewId, uint ReviewId, address payable issuer, string reviewFileHash);
    event BountyAdd(uint256 smartReviewId, uint amount, address from, address to, uint256 smartReveiwPhase);
    event SmartReviewCompleted(uint256 nowTime, uint256 deadline, uint256 amount, uint256 smartReviewId, uint256 smartReveiwPhase);
    event ReviewComplete(uint256 smartReviewId, uint256 reviewId);

    constructor(address smts_) {
        smts = IERC20(smts_);
        governor = 0x8939843484975DD23b30951FEac7317335969ec3;  // TODO: This is for testing, reset to official Governor
    }

    modifier onlyGovernor {
        require(msg.sender == governor, "Only Governor allowed");
        _;
    }

    function getSmartReviewsCount() external view returns(uint256) {
        return AllSmartReviews.length;
    }
    function getSmartReviewById(uint id) external view returns(SmartReview memory) {
        require(id < id_counter_smartReview && id >= 0, "Invalid smart review id");
        return SmartReviewsMapping[id];
    }
    function getReviewsBySmartReviewId(uint smartReviewId) external view returns(Review[] memory) { 
        require(smartReviewId < id_counter_smartReview && smartReviewId >= 0, "Invalid smart review id");
        return ReviewsMapping[smartReviewId];
    }
    function getReviewsCountBySmartReviewId(uint smartReviewId) external view returns(uint256) { 
        require(smartReviewId < id_counter_smartReview && smartReviewId >= 0, "Invalid smart review id");
        return ReviewsMapping[smartReviewId].length;
    }
    function getReviewById(uint smartReviewId, uint reviewId) external view returns(Review memory) {
        require(smartReviewId < id_counter_smartReview && smartReviewId >= 0, "Invalid smart review id");
        require(reviewId < ReviewsMapping[smartReviewId].length && reviewId >= 0, "Invalid review id");
        return ReviewsMapping[smartReviewId][reviewId]; 
    }

    function publishSmartReview(address payable[] calldata issuers, string calldata ipHash, string calldata requirementsHash, uint256 deadline, uint256 bountyAmount,string[2] calldata info) external returns(bool) {  
        SmartReview memory newReview = SmartReview(issuers, ipHash, requirementsHash, deadline, SmartReveiwPhases.PAUSED, bountyAmount, 0, info);
        SmartReviewsMapping[id_counter_smartReview] = newReview;
        AllSmartReviews.push(newReview);
        id_counter_smartReview++;
        //emit event
        emit SmartReviewPublished(issuers, ipHash, requirementsHash, deadline, bountyAmount, id_counter_smartReview - 1);
        
        return true;
    }
    function addBountyToSmartReview(uint256 smartReviewId, uint256 amount) public returns(bool){ 
        // transfer the bounty amount from the address of the caller to this contract address
        require(smts.transferFrom(msg.sender,address(this), amount), "error in tranfer token to the SmartReview Contract");
        SmartReviewsMapping[smartReviewId].currentBalance += amount;
        if(SmartReviewsMapping[smartReviewId].currentBalance >=  SmartReviewsMapping[smartReviewId].bountyAmount){
             SmartReviewsMapping[smartReviewId].phase = SmartReveiwPhases.ACTIVE;
        }
        emit BountyAdd(smartReviewId, amount, msg.sender, address(this), uint256(SmartReviewsMapping[smartReviewId].phase));
        return true;
    }

    function completeReview(uint256 reviewId, uint256 smartReviewId) onlyGovernor external returns (bool) {
        // TODO: complete the full logic to complete a review
        require(smartReviewId < id_counter_smartReview && smartReviewId >= 0, "Invalid smart review id");
        require(reviewId < ReviewsMapping[smartReviewId].length && reviewId >= 0, "Invalid review id");

        ReviewsMapping[smartReviewId][reviewId].phase = ReveiwPhases.ACCEPTED;
        emit ReviewComplete(smartReviewId, reviewId);
        return true;
    }

    // complete the review acception
    function completeSmartReview(uint256 smartReviewId) public returns(bool) {
        // check current date is after dealine
        uint256 nowTime = block.timestamp;
        require(SmartReviewsMapping[smartReviewId].deadline < nowTime, "Smart Review can not be completed, it has not passed deadline yet");
        require(smartReviewId < id_counter_smartReview && smartReviewId >= 0, "Invalid smart review id");
        require(SmartReviewsMapping[smartReviewId].phase == SmartReveiwPhases.ACTIVE, "Smart Review should be active before complete!");

        Review[] memory reviews = ReviewsMapping[smartReviewId];
        // smts.approve(address(this), 2^256 - 1);
        uint256 transferAmount = 0;
        uint256 reviewCompleteCount = 0;

        for (uint i = 0; i < reviews.length; i++) {
            if (reviews[i].phase == ReveiwPhases.ACCEPTED) {
                reviewCompleteCount += 1;
            }
        }

        if (reviewCompleteCount > 0) {
            transferAmount = SmartReviewsMapping[smartReviewId].currentBalance / reviewCompleteCount;
        }
        
        for (uint256 i = 0; i < reviews.length && reviewCompleteCount > 0; i++) {
            if (reviews[i].phase == ReveiwPhases.ACCEPTED) {
                    require(smts.transfer(
                        reviews[i].issuer,
                        transferAmount
                    ), string.concat("Transfer failed for issuer ", Strings.toHexString(uint160(address(reviews[i].issuer)), 20))
                );
            }
        
        }
        // if no reviews at all, there will be no transfer and the amount will stay in the main contract.

        SmartReviewsMapping[smartReviewId].currentBalance = 0;

      
        SmartReviewsMapping[smartReviewId].phase = SmartReveiwPhases.COMPLETE;

        emit SmartReviewCompleted(nowTime, SmartReviewsMapping[smartReviewId].deadline, transferAmount, smartReviewId, uint256(SmartReviewsMapping[smartReviewId].phase));
        return true;
    }
    
    // Check if the reviewer is one of the issuer
    function exists(address payable[] memory issuers, address payable reviewer) private pure returns (bool) {
        for (uint i = 0; i < issuers.length; i++) {
            if (issuers[i] == reviewer) {
                return true;
            }
        }
        return false;
    }

    function publishReview(string calldata reviewFileHash, uint smartReviewId, string calldata proposal_id) external returns (bool){
        require(smartReviewId < id_counter_smartReview && smartReviewId >= 0, "Invalid smart review id");
        SmartReview memory SmartReviewObj = SmartReviewsMapping[smartReviewId];
        require(!exists((SmartReviewObj.issuers), payable(msg.sender)), "Author can not review his/her own IPs.");
        Review memory Reviewobj = Review(payable(msg.sender), reviewFileHash, ReveiwPhases.ACTIVE, proposal_id);
        ReviewsMapping[smartReviewId].push(Reviewobj);
        //emit event
        emit ReviewPublished(smartReviewId, ReviewsMapping[smartReviewId].length, payable(msg.sender), reviewFileHash);
        return true;
    }
    
}
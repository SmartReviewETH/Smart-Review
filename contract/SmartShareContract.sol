// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SmartShareContract {
    mapping (address => SmartReview[]) public SmartReviews;
    uint id_counter = 0; // counter for id
    enum SmartReveiwPhases {ACTIVE, PAUSED, PAID, EXPIRED}


    /// @dev Structs
    struct SmartReview {
        address payable[] issuers;
        string ipHash;
        string requirementsHash;
        uint256 deadline;
        SmartReveiwPhases phase;
    }
   
    // function getOne() public view returns () {
    //     return SmartReviews;
    // }
    function IssueSmartReview(address payable[] calldata issuers, string calldata ipHash, string calldata requirementsHash, uint256 deadline) external returns(bool) {  

         for (uint i=0; i<issuers.length; i++) {
            address currentIssuer = issuers[i];
            SmartReview memory newReview = SmartReview(issuers,ipHash,requirementsHash,deadline,SmartReveiwPhases.ACTIVE);
            SmartReviews[currentIssuer].push(newReview);
        }
     
        // TODO:emit event
        return true;
    }
}
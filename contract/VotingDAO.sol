// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
// import "contract/SmartReviewContract.sol";

contract VotingDAO is Ownable {
 
    struct ProposalData {
        uint smartReviewId;
        string description;
        string reviewFileHash;
        uint256 createdAt;
        address proposer;
        bool executed;
    }
   constructor(address initialOwner) Ownable(initialOwner) {}

   function createProposal() public returns(bool){
    // TODO
   }
}
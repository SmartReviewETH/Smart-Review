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
        uint good;   // number of viewers think this is good
        uint bad;    // number of viewers think this is bad
        // Simple mapping to check if a member has voted good
        mapping (address => bool) votedGood;
        // Simple mapping to check if a member has voted bad
        mapping (address => bool) votedBad;
    }
    constructor(address initialOwner) Ownable(initialOwner) {}

    // Create a mapping of ID to Proposal
    mapping(uint => ProposalData) public proposals;

    modifier onlyMember() {
        // TODO
        _;
    }

    modifier onlyUnexecuted(uint proposalIndex) {
        require(!proposals[proposalIndex].executed, "Only unexecuted proposal can be executed.");
        _;
    }

    function createProposal() public onlyMember returns(bool){
        // TODO
    }

    function vote() public onlyMember {
        // TODO
    }

    function unVote() public onlyMember {
        // TODO
    }

    function executeReward(uint proposalIndex) public onlyMember onlyUnexecuted(proposalIndex) {
        // TODO
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "contract/SmartReviewContract.sol";

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
    constructor(address initialOwner) Ownable(initialOwner) {
        proposalId = 0;
    }

    // Create a mapping of ID to Proposal
    mapping(uint => ProposalData) public proposals;
    uint public proposalId;

    // To chech if an address is a member of the DAO
    mapping(address => bool) isMember;

    event proposalCreated(uint id, string description, address proposer);

    modifier onlyMember() {
        require(isMember[msg.sender], "Only member allowed.");
        _;
    }

    modifier onlyUnexecuted(uint proposalIndex) {
        require(!proposals[proposalIndex].executed, "Only unexecuted proposal can be executed.");
        _;
    }

    function createProposal(uint _smartReviewId, string memory _description, string memory _reviewFileHash, address _proposer) public onlyMember returns(bool){
        ProposalData storage new_proposal = proposals[proposalId];
        new_proposal.smartReviewId = _smartReviewId;
        new_proposal.description = _description;
        new_proposal.reviewFileHash = _reviewFileHash;
        new_proposal.proposer = _proposer;
        new_proposal.createdAt = block.timestamp;
        new_proposal.good = 0;
        new_proposal.bad = 0;
        new_proposal.executed = false;
        emit proposalCreated(proposalId, _description, _proposer);
        proposalId++;
    }

    function vote(uint _proposalId, bool _approve) public onlyMember {
        ProposalData storage proposal = proposals[_proposalId];

        if(_approve){
            proposal.good++;
        }
        else{
            proposal.bad++;
        }
    }

    function unVote() public onlyMember {
        // TODO
    }

    function executeReward(uint proposalIndex) public onlyMember onlyUnexecuted(proposalIndex) {
        // TODO
    }

    function addMember(address _member) public onlyOwner {
        isMember[_member] = true;
    }

    function removeMember(address _member) public onlyOwner {
        isMember[_member] = false;
    }

}

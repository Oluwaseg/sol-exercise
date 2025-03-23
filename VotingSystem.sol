// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VotingSystem {
    struct Candidate {
        string name;
        uint voteCount;
    }
    
    address public owner;
    mapping(address => bool) public voters;
    Candidate[] public candidates;
    
    event Voted(address indexed voter, uint candidateIndex);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    constructor(string[] memory candidateNames) {
        owner = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }
    
    function vote(uint candidateIndex) public {
        require(!voters[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");
        
        voters[msg.sender] = true;
        candidates[candidateIndex].voteCount++;
        
        emit Voted(msg.sender, candidateIndex);
    }
    
    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }
}

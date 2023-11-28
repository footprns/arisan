// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Arisan {
    address public manager;
    uint public arisanAmount;
    address[] public participants;
    mapping(address => bool) public hasWon; // Mapping to track participants who have won

    modifier restricted() {
        require(msg.sender == manager, "Only the manager can call this function");
        _;
    }

    constructor(uint _arisanAmount) {
        manager = msg.sender;
        arisanAmount = _arisanAmount;
    }

    function joinArisan() public payable {
        require(msg.value == arisanAmount, "Incorrect Arisan amount");
        participants.push(msg.sender);
    }

    function pickWinner() public restricted {
        require(participants.length > 0, "No participants in the Arisan");

        // Use a pseudo-random function based on the current block's timestamp and participants' addresses
        uint randomNumber = uint(keccak256(abi.encodePacked(block.timestamp, participants))) % participants.length;
        
        // Choose the winner
        address winner = participants[randomNumber];

        // Ensure that the winner has not won before
        require(!hasWon[winner], "Participant has already won");

        // Mark the winner as having won
        hasWon[winner] = true;

        // Send the collected funds to the winner
        payable(winner).transfer(address(this).balance);
    }

    function getParticipants() public view returns (address[] memory) {
        return participants;
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}

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

    constructor(uint _arisanAmount, address[] memory _initialParticipants) {
        require(_initialParticipants.length > 0, "At least one initial participant is required");
        manager = msg.sender;
        arisanAmount = _arisanAmount;
        participants = _initialParticipants;
    }

    function joinArisan() public payable {
        require(msg.value == arisanAmount, "Incorrect Arisan amount");
        require(isParticipant(msg.sender), "You are not an initial participant");
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

    function isParticipant(address participant) internal view returns (bool) {
        for (uint i = 0; i < participants.length; i++) {
            if (participants[i] == participant) {
                return true;
            }
        }
        return false;
    }
}

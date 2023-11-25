// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity <=0.8.13;

contract Arisan {
    address payable[] public owners;
    uint256 public unlockTimestamp;

    constructor(address payable[] memory _owners) {
        require(_owners.length == 3, "Three owners are required");
        owners = _owners;
        // Set the unlock time to one week from contract deployment
        unlockTimestamp = block.timestamp + 1 minutes;
    }


    modifier onlyAfterUnlock() {
        require(block.timestamp >= unlockTimestamp, "Funds cannot be withdrawn before unlock time");
        _;
    }

    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function withdraw(uint _amount) external onlyAfterUnlock {
        require(isOwner(msg.sender), "Caller is not an owner");
        require(address(this).balance >= _amount, "Insufficient funds");
        payable(msg.sender).transfer(_amount);
    }

    function isOwner(address account) internal view returns (bool) {
        for (uint256 i = 0; i < owners.length; i++) {
            if (owners[i] == account) {
                return true;
            }
        }
        return false;
    }

    // Function to get the remaining time until unlock
    function getRemainingTime() external view returns (uint256) {
        if (block.timestamp >= unlockTimestamp) {
            return 0;
        } else {
            return unlockTimestamp - block.timestamp;
        }
    }
}
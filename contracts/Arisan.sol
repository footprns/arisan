// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity <=0.8.13;

contract Arisan {
    address payable[] public owners;

    constructor(address payable[] memory _owners) {
        require(_owners.length == 3, "Three owners are required");
        owners = _owners;
    }
}
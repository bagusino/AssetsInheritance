// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Inheritance.sol";

contract InheritanceFactory {
    event InheritanceCreated(address indexed owner, address inheritanceContract);

    mapping(address => address) public userContracts;
    address[] public allContracts;

    function createInheritanceContract() public {
        require(userContracts[msg.sender] == address(0), "User already has an inheritance contract");

        Inheritance newContract = new Inheritance(msg.sender);
        userContracts[msg.sender] = address(newContract);
        allContracts.push(address(newContract));

        emit InheritanceCreated(msg.sender, address(newContract));
    }

    function getAllContracts() public view returns (address[] memory) {
        return allContracts;
    }

    function getUserContract(address user) public view returns (address) {
        return userContracts[user];
    }
}

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Inheritance.sol";

/**
 * @title InheritanceFactory
 * @notice This contract aims to be used by a web platform to deploy dinamically inheritance contracts
 */

contract InheritanceFactory {
    event InheritanceCreated(address indexed owner, address inheritanceContract); // Event to notify that an inheritance contract has been created

    mapping(address => address) public userContracts; // Mapping of the users and their contracts

    function createInheritanceContract(address[] memory _heirs) public {
        Inheritance newContract = new Inheritance(msg.sender, _heirs);
        userContracts[msg.sender] = address(newContract);
        emit InheritanceCreated(msg.sender, address(newContract));
    }
    /*
    * @notice Function to get the contract of a user
    * @param user The address of the owner
    * @return The address of the contract of the user
    * TODO: Check if there are more than 1 contract if are all returned. 
    * If I believe the work of a mapping it will only return 1 contract (tree structure)
    */
    function getUserContract(address user) public view returns (address) {
        return userContracts[user];
    }
}

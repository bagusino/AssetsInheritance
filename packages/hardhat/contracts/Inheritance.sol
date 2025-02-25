// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Inheritance is Ownable {
    uint256 public lastCheckIn;
    uint256 public checkInInterval = 365 days;
    mapping(address => bool) public isHeir;
    address[] public heirs;

    event FundsDeposited(address indexed from, uint256 amount);
    event InheritanceDistributed();

    constructor(address _owner) Ownable(_owner) {
        lastCheckIn = block.timestamp;
    }

    function checkIn() public onlyOwner {
        lastCheckIn = block.timestamp;
    }

    function addHeir(address heir) public onlyOwner {
        require(heir != msg.sender, "Owner cannot be an heir");
        require(!isHeir[heir], "Heir already exists");
        isHeir[heir] = true;
        heirs.push(heir);
    }

    function removeHeir(address heir) public onlyOwner {
        require(isHeir[heir], "Heir not found"); // TBD check if this is neccesary
        isHeir[heir] = false;
    }

    function distributeInheritance() public {
        require(block.timestamp > lastCheckIn + checkInInterval, "Owner is still alive");
        uint256 balance = address(this).balance;
        uint256 share = balance / heirs.length;
        for (uint256 i = 0; i < heirs.length; i++) {
            if (isHeir[heirs[i]]) {
                payable(heirs[i]).transfer(share);
            }
        }
        emit InheritanceDistributed();
    }

    receive() external payable {
        require(msg.value > 0, "Must send ETH");
        emit FundsDeposited(msg.sender, msg.value);
    }
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        emit FundsDeposited(msg.sender, msg.value);
    }
    function withdraw() external onlyOwner {
        require(block.timestamp > lastCheckIn + checkInInterval, "Owner is still alive");
        payable(owner()).transfer(address(this).balance);
    }
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }


}

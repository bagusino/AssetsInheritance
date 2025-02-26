// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @title Inheritance
 * @author bagusino
 * @notice This contract aims to be used by a web platform to deploy dinamically inheritance contracts
 * TODO: Destroy the contract after the inheritance has been done
 */
contract Inheritance is Ownable {

    uint256 public lastCheckIn; //Last time when the owner logged in
    uint256 public checkInInterval = 365 days; // Interval of days until inherit functionality is active
    mapping(address => bool) public isHeir; // Mapping of heirs
    address[] public heirs; // Array of heirs

    event FundsDeposited(address indexed from, uint256 amount); // Event to notify that funds are deposited
    event InheritanceDistributed(); // Event to notify that the inheritance has been done
    /*  
    * @notice Constructor of the contract
    * @param _owner The owner of the contract
    * @param _heirs The heirs of the contract 
    * TODO: Add require to check that the owner is not an heir
    *       Improve gas efficiency by using a mapping for heirs
    */
    constructor(address _owner, address[] memory _heirs) Ownable(_owner) {
        lastCheckIn = block.timestamp;
        for (uint256 i = 0; i < _heirs.length; i++) {
            require(_heirs[i] != _owner, "Owner cannot be an heir");
            require(!isHeir[_heirs[i]], "Heir already exists");
            isHeir[_heirs[i]] = true;
            heirs.push(_heirs[i]);
        }
    }
    /*
    * @notice Function to check in the owner
    */
    function checkIn() public onlyOwner {
        lastCheckIn = block.timestamp;
    }
    /*
    * @notice Function to add an heir
    * @param _heir The address of the heir
    */
    function addHeir(address _heir) public onlyOwner {
        require(_heir != msg.sender, "Owner cannot be an heir");
        require(!isHeir[_heir], "Heir already exists");
        isHeir[_heir] = true;
        heirs.push(_heir);
    }
    /*
    * @notice Function to remove an heir
    * @param _heir The address of the heir
    * TODO: Remove the heir from the heirs array. 
    *      Take in account the gas efficiency
    */
    function removeHeir(address _heir) public onlyOwner {
        isHeir[_heir] = false;
    }
    /*
    * @notice Function to distribute the inheritance that the heirs can use to withdraw the funds
    */
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
    /*
    * @notice Function to deposit funds to the contract
    */
    receive() external payable {
        require(msg.value > 0, "Must send ETH");
        emit FundsDeposited(msg.sender, msg.value);
    }
    /*
    * @notice Function to deposit the funds of the contract
    * TODO: Think about if this function will be available only by the owner
    */
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        emit FundsDeposited(msg.sender, msg.value);
    }
    /*
    * @notice Function to withdraw the funds of the contract to the owner
    */
    function withdraw() external onlyOwner {
        require(block.timestamp > lastCheckIn + checkInInterval, "Owner is still alive");
        payable(owner()).transfer(address(this).balance);
    }
    /*
    * @notice Function to get the balance of the contract
    */
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

}

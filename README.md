# Inheritance Smart Contract

## Description
This project implements a smart contract for inheritance distribution using **Solidity** and **Scaffold-ETH2**. The contract allows an owner to register heirs and set a check-in mechanism. If the owner does not check in within a set period, the funds in the contract are automatically distributed to the heirs. 
*This is a work in progress project, please take it as a reference under your own responsability.*

## Features
There are two Smart Contracts in this project Inheritance and InheritanceFactory
### Inheritance
- The owner can add or remove heirs.
- The owner must check in periodically to confirm they are alive.
- The period of time should be configurable and only available to the owner
- If the owner fails to check in within a set time, the contract distributes its balance among the heirs.
TODO: - There is a 1% fee when the distribution is done.
TODO: - Add support for more assets
- Supports adding funds.
### InheritanceFactory
This contract aims to create instances of the previous one with the configuration that the owner want to stablish.
- The creation of a contract has limits, in terms of period of time and heirs (To be determined these thresholds)

## Technologies Used
- **Solidity** (Smart contract development)
- **Scaffold-ETH** (Development environment)
- **Hardhat** (Smart contract testing and deployment)
- **OpenZeppelin** (Security enhancements)

## Installation & Setup

### Prerequisites
Make sure you have the following installed:
- [Node.js](https://nodejs.org/)
- [Yarn](https://yarnpkg.com/)
- Hardhat & dependencies

   **TBD**

## License
This project is licensed under the MIT License.

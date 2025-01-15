## Introduction

This project allows users to fund a contract with ETH equivalent to a minimum value of 5 USD at the time of the transaction and allows the owner/deployer of the contract to withdraw funds.

# Tech Stack

1. Foundry
2. Anvil
3. Cast
4. Forge
5. Solidity
6. ChainLink
7. GitHub
8. Make
9. Alchemy

## Tech Usage

### 1. **Anvil**

Anvil is a local Ethereum node used for testing and simulating Ethereum transactions. It is part of the Foundry suite and is specifically designed for rapid and efficient local blockchain testing. In this project, Anvil is used to simulate a local Ethereum network where you can deploy contracts and test transactions without interacting with the mainnet or any test networks. Anvil also allows you to set up a controlled environment with mock data (e.g., mock price feeds from ChainLink).

- **Usage**: It is the local Ethereum node that the project connects to during development and testing. Anvil provides a fast and cost-effective way to test the contract functionalities without relying on external networks.

### 2. **ChainLink**

ChainLink is a decentralized oracle network that provides reliable real-world data to smart contracts on the blockchain. In this project, ChainLink is used to fetch the current price of Ether (ETH) in USD through its price feed, which is crucial to the contract's functionality. The contract checks if the amount of ETH being funded by users is equivalent to at least $5 USD (in the case of Ethereum) by leveraging ChainLink’s real-time price feed.

- **Usage**: ChainLink’s price feed is used to convert ETH to USD in the `FundMe` contract to ensure that users are funding the contract with at least $5 USD worth of ETH. You will install the ChainLink’s Brownie contracts to interact with the price feed.

### 3. **Cast**

Cast is a command-line interface (CLI) tool provided by Foundry for interacting with smart contracts on the blockchain. It allows you to query contract state, call functions, and send transactions directly from the terminal.

- **Usage**: Cast is used to interact with deployed contracts for tasks such as calling functions or checking contract state, especially when working with local or test networks.

### 4. **Forge**

Forge is a framework within Foundry designed to help developers test, deploy, and interact with smart contracts. It integrates tightly with Solidity, making it easier to write unit tests for your contracts, manage dependencies, and automate the deployment process.

- **Usage**: Forge is used to compile and test the smart contracts in this project. It helps with managing dependencies, running tests, and deploying contracts to local or test networks. The `forge test` command is also used for testing contract functionality.

### 5. **Solidity**

Solidity is the programming language used to write smart contracts on the Ethereum blockchain. It is a statically-typed language that allows developers to implement complex logic for decentralized applications (dApps).

- **Usage**: The contract in this project is written in Solidity, which defines the logic for allowing users to fund the contract with ETH and for the owner to withdraw the funds. Solidity also defines how ChainLink price feeds are used for validating the funding amount in USD.

### 6. **GitHub**

GitHub is a platform for version control and collaboration. It is used by developers to store code repositories, manage versions of code, and collaborate with other developers.

- **Usage**: GitHub is used for managing the source code of this project, tracking issues, and collaborating on code changes. The repository includes the full source code, as well as configuration files for working with the Foundry toolchain.

### 7. **Make**

Make is a build automation tool that simplifies running scripts, compiling code, and managing dependencies. In this project, Make is used to automate the process of deploying contracts, running tests, and setting up the development environment. By using Make, you can define repeatable and organized tasks, improving the development workflow.

- **Usage**: Make automates tasks such as starting the local Anvil blockchain, compiling contracts, running tests, deploying the contract to a test network, and interacting with the deployed contracts. For instance, you can use `make test-sepolia` to run the tests for your contracts or `make deploy-sepolia` to deploy the contract to a specified network. Make helps keep the development process more streamlined and reduces the need for manually executing individual commands.

### 8. **Alchemy**

**Alchemy** is a blockchain infrastructure platform that provides powerful tools to developers for building, testing, and deploying decentralized applications (dApps) on the blockchain. It offers access to nodes on multiple blockchains, including Ethereum, Polygon, Solana, and more, making it a popular choice for both testnets and mainnet blockchain development.

In this project, Alchemy is used to spin up Ethereum nodes for various networks, including Sepolia and Mainnet. These nodes are essential for interacting with smart contracts deployed on these networks, especially when performing tasks such as sending transactions, reading contract state, or broadcasting transactions.

- **Usage**: Alchemy is used to provide RPC (Remote Procedure Call) access to various Ethereum networks, ensuring that the project can interact with different chains without having to manage individual nodes manually. By using Alchemy’s API, the project can connect to the Sepolia and Mainnet Ethereum nodes via URLs provided by Alchemy, streamlining development and testing workflows. It is particularly useful for tasks such as forking from Sepolia or Mainnet for testing or deployment using the `--rpc-url` parameter in Forge.

---

## Dependencies Installation

### 1. **ChainLink**

To use ChainLink's price feeds, you need to install the ChainLink Brownie contracts, which provide the necessary interfaces for interacting with their decentralized oracles. You can install it using the following command:

```bash forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit ```

### 2. **FoundryDevops**

To use FoundryDevops, use this command:
```bash forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit```


## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/marawanthedev/fund-me-foundry.git
   ```
   or
   ```bash
   git clone git@github.com:marawanthedev/fund-me-foundry.git
   ```

2. Set up environment variables, refer to .env.example for guidance:
   ```bash
    SEPOLIA_RPC_URL=
    MAINNET_RPC_URL=
    ETHERSCAN_API_KEY=
    PRIVATE_KEY=
   ```


## Useful commands


### 1. Testing

    - local test: make test
    - sepolia chain test: make test-sepolia
    - mainnet chain test: make test-mainnetP
    - test coverage: make coverage

### 2. Deployment
    - local anvil deployment: make deploy
    - sepolia chain deployment: make deploy-sepolia
    - mainnet chain deployment: make deploy-mainnet

### 2. Build/Compile
    - build: make build
    - compile: make compile

## Folder Structure

The project has the following directory structure:

.
├── Makefile
├── README.md
├── broadcast
│   └── FundMe.s.sol
├── cache
│   ├── FundMe.s.sol
│   └── solidity-files-cache.json
├── foundry.toml
├── lib
│   ├── chainlink-brownie-contracts
│   ├── forge-std
│   └── foundry-devops
├── out
│   ├── AggregatorV3Interface.sol
│   ├── Base.sol
│   ├── DevOpsTools.sol
│   ├── FundMe.s.sol
│   ├── FundMe.sol
│   ├── FundMe.t.sol
│   ├── FundMeIntegration.t.sol
│   ├── HelperConfig.s.sol
│   ├── IERC165.sol
│   ├── IERC20.sol
│   ├── IERC721.sol
│   ├── IMulticall3.sol
│   ├── Interactions.s.sol
│   ├── MockERC20.sol
│   ├── MockERC721.sol
│   ├── MockV3Aggregator.sol
│   ├── PriceConverter.sol
│   ├── Script.sol
│   ├── StdAssertions.sol
│   ├── StdChains.sol
│   ├── StdCheats.sol
│   ├── StdError.sol
│   ├── StdInvariant.sol
│   ├── StdJson.sol
│   ├── StdMath.sol
│   ├── StdStorage.sol
│   ├── StdStyle.sol
│   ├── StdToml.sol
│   ├── StdUtils.sol
│   ├── StringUtils.sol
│   ├── Test.sol
│   ├── Vm.sol
│   ├── build-info
│   ├── console.sol
│   └── safeconsole.sol
├── script
│   ├── FundMe.s.sol
│   ├── HelperConfig.s.sol
│   └── Interactions.s.sol
├── src
│   ├── FundMe.sol
│   └── PriceConverter.sol
└── test
    ├── integrations
    ├── mocks
    └── unit
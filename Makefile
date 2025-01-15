-include .env
build:; forge build

# deployment

deploy:
			forge script script/FundMe.s.sol:DeployFundMe --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_DEFAULT_PRIVATE_KEY) --broadcast -vvvv

deploy-sepolia:
			forge script script/FundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-mainnet:
			forge script script/FundMe.s.sol:DeployFundMe --rpc-url $(MAINNET_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

# test
test: forge test -vvv

test-sepolia:
		forge test --fork-url $(SEPOLIA_RPC_URL)

test-mainnet:
		forge test --fork-url $(MAINNET_RPC_URL)

coverage:
	forge coverage


fund:
	 forge script script/Interactions.s.sol:FundMeFund $(NETWORK_ARGS)

withdraw:
	 forge script script/Interactions.s.sol:FundMeWithdraw $(NETWORK_ARGS)
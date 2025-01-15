// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// fund
// withdraw

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeFund is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fund(mostRecentlyDeployed);
    }

    function fund(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
    }
}

contract FundMeWithdraw is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdraw(mostRecentlyDeployed);
    }

    function withdraw(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }
}

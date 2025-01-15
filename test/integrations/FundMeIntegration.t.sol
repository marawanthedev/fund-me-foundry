// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/FundMe.s.sol";
import {FundMeFund, FundMeWithdraw} from "../../script/Interactions.s.sol";

contract FundMeTestIntegration is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_VALUE = 100000;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFund() public {
        uint256 ownerStartingBalance = fundMe.getOwner().balance;

        FundMeFund fundMeFund = new FundMeFund();
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        uint256 contractBalancePostFunds = address(fundMe).balance;

        FundMeWithdraw fundMeWithDraw = new FundMeWithdraw();
        fundMeWithDraw.withdraw(address(fundMe));

        uint256 contractBalancePostWithdraw = address(fundMe).balance;

        uint256 ownerEndingBalance = fundMe.getOwner().balance;

        assert(contractBalancePostWithdraw == 0);
        assertEq(
            ownerEndingBalance,
            contractBalancePostFunds + ownerStartingBalance
        );
    }
}

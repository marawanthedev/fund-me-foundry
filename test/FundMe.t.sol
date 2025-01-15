// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/FundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 public constant MAINNET_CHAIN_ID = 1;
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_VALUE = 100000;
    uint256 constant TX_GAS_PRICE = 1;

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    modifier owner() {
        vm.prank(fundMe.getOwner());
        _;
    }

    function setUp() external {
        // deploy contract
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMiniumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMessageSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testFundFailsWithoutEnoughEth() public funded {
        vm.expectRevert();
        fundMe.fund();
    }

    function testWithDrawFailsIfNotOwner() public funded {
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithDrawSuccedsWithOwner() public funded {
        // arrange
        uint256 ownerStartingBalance = fundMe.getOwner().balance;
        uint256 contractStartingBalance = address(fundMe).balance;

        // act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        // assert
        uint256 ownerEndingBalance = fundMe.getOwner().balance;
        uint256 contractEndingBalance = address(fundMe).balance;

        assertEq(contractEndingBalance, 0);
        assertEq(
            ownerEndingBalance,
            contractStartingBalance + ownerStartingBalance
        );
    }

    function testFundSucceedsWithEnoughEth() public funded {
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        uint8 expectedVersion = 4;

        if (block.chainid == MAINNET_CHAIN_ID) {
            expectedVersion = 6;
        }

        assertEq(version, expectedVersion);
    }

    function testReceiveAttemptToFund() public {
        vm.prank(USER);
        (bool success, ) = address(fundMe).call{
            value: SEND_VALUE,
            gas: GAS_VALUE
        }("");

        require(success, " Receive Transaction has failed.");
    }

    function testFallBackAttemptToFund() public {
        vm.prank(USER);
        (bool success, ) = address(fundMe).call{value: SEND_VALUE}(
            abi.encodePacked("param values")
        );
        require(success, " FallBack Transaction has failed.");
    }

    function testBalanceIncreasesAfterReceiveOrFallBackTransaction() public {
        uint256 initialBalance = address(fundMe).balance;

        testReceiveAttemptToFund();

        uint256 balanceAfterReceive = address(fundMe).balance;

        assertEq(
            balanceAfterReceive,
            initialBalance + SEND_VALUE,
            "Balance should increase by SEND_VALUE after receive"
        );

        testFallBackAttemptToFund();

        uint256 balanceAfterFallback = address(fundMe).balance;

        assertEq(balanceAfterFallback, (SEND_VALUE * 2));
    }

    function testAddressToAmountValueIsCorrect() public funded {
        uint256 fundedAmount = fundMe.getAddressToAmountFunded(address(USER));
        assertEq(fundedAmount, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public funded {
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    function testWithDrawFromMultipleFunders() public {
        //  arrange
        uint256 ownerStartingBalance = fundMe.getOwner().balance;

        // act
        for (uint160 i = 0; i < 10; i++) {
            hoax(address(i), SEND_VALUE); // hoax is a mix of prank and deal altogether
            fundMe.fund{value: SEND_VALUE, gas: GAS_VALUE}();
        }

        uint256 contractMaxBalance = address(fundMe).balance;
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        // assert
        uint256 ownerEndingBalance = fundMe.getOwner().balance;
        uint256 contractEndingBalance = address(fundMe).balance;

        assertEq(contractEndingBalance, 0);
        assertEq(ownerEndingBalance, contractMaxBalance + ownerStartingBalance);
    }
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe} from "../../script/Interactions.s.sol";

contract InteragtionTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant ETH_1 = 1e18;
    uint256 constant USER_STARTING_BALANCE = 10e18;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, USER_STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        vm.prank(USER);
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        assertEq(address(fundMe).balance, ETH_1);
    }
}

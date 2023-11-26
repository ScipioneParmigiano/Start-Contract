// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {BCToken} from "BCToken_.sol";

contract MyProtocol {
    mapping(address => uint) addressToAmountDeposited;
    BCToken BCT;

    constructor(address BCTAddr) {
        BCT = BCToken(BCTAddr);
    }

    function deposit(uint amount) public {
        bool success = BCT.transferFrom(msg.sender, address(this), amount);
        if (!success) revert();

        addressToAmountDeposited[msg.sender] += amount;
    }

    function redeem(uint256 amount) public {
        bool success = BCT.transfer(msg.sender, amount);
        if (!success) revert();

        addressToAmountDeposited[msg.sender] -= amount;
    }

    function returnAmountDeposited() public view returns (uint256) {
        return addressToAmountDeposited[msg.sender];
    }

    function userBCTBalance(address a) public view returns (uint256) {
        return BCT.balanceOf(a);
    }
}

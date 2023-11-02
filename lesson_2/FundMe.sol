//SPDX-License-Identifier: MIT
pragma solidity >0.8.1;

contract FundMe {
    address owner;
    mapping(address => uint256) addressToAmountFunded;
    uint256 minAmount;
    uint256 maxAmount;

    // constructor is a particular function called only when the the contract is deployed
    constructor(uint256 _min, uint256 _max) {
        owner = msg.sender;
        minAmount = _min;
        maxAmount = _max;
    }

    // modifiers are piece of code you may want to reuse
    modifier onlyOwner() {
        if (msg.sender != owner) revert(); // revert is a special keyword used to invalidate the transaction associated to a function
        _; // _ assert that the modifier is concluded
    }

    function fundMyProject() public payable {
        if (msg.value > maxAmount) revert();
        if (msg.value < minAmount) revert();
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function totalFundsLocked() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw(uint256 amount) public payable onlyOwner {
        payable(msg.sender).transfer(amount);
    }
}

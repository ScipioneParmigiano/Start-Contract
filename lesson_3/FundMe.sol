//SPDX-License-Identifier: MIT
pragma solidity >0.8.1;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    address owner;
    mapping(address => uint256) addressToAmountFunded;
    uint256 maxAmount = 5000 * 10 ** 18; // for some reason we can't accept more than 5000 USD
    uint256 priceFeedPrecision = 10 ** 10;
    AggregatorV3Interface priceFeed;

    // constructor is a particular function called only when the the contract is deployed
    constructor() {
        owner = msg.sender;
    }

    // modifiers are piece of code you may want to reuse
    modifier onlyOwner() {
        if (msg.sender != owner) revert(); // revert is a special keyword used to invalidate the transaction associated to a function
        _; // _ assert that the modifier is concluded
    }

    function fundMyProject() public payable {
        uint256 ethAmountInUsd = ethToUsd(msg.value) / 1e18;
        if (ethAmountInUsd > maxAmount) revert("too much");
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function ethToUsd(uint256 amount) public returns (uint256) {
        priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306 //eth to usd on sepolia
        );
        (, int price, , , ) = priceFeed.latestRoundData();

        return uint256(price) * amount * priceFeedPrecision;
    }

    function withdraw(uint256 amount) public payable onlyOwner {
        payable(msg.sender).transfer(amount);
    }
}

//SPDX-License-Identifier: MIT
pragma solidity >0.8.1;

import {Token} from "Token.sol";
import {NFT} from "NFT.sol";

contract FundMe {
    mapping(address => uint256) addressToAmountFunded;
    Token token;
    NFT nft;

    constructor() {
        token = new Token();
        nft = new NFT();
    }

    // the function mint to the funder some erc20 and an erc721
    function fundMyProject() public payable {
        addressToAmountFunded[msg.sender] += msg.value;

        // erc20
        token.mint(msg.sender, msg.value);

        // erc721
        nft.safeMint(msg.sender);
    }

    function withdraw(uint256 amount) public payable {
        payable(msg.sender).transfer(amount);
    }

    function nftAddress() public view returns (address) {
        return address(nft);
    }

    function tokenAddress() public view returns (address) {
        return address(token);
    }
}

//SPDX-License-Identifier: MIT
pragma solidity >0.8.1;

/* This Solidity contract is a simple crowdfunding contract (FundMe). 
It allows users to fund a project by sending Ether, and in return, it mints ERC20 tokens (Token contract)
and ERC721 tokens (NFT contract) to the funder. Users can also withdraw funds, and the contract provides functions 
to retrieve the addresses of the ERC721 and ERC20 contracts. */

import {Token} from "Token.sol";
import {NFT} from "NFT.sol";
// Imports the Token and NFT contracts from external files.

contract FundMe {

    mapping(address => uint256) addressToAmountFunded;
    // Mapping to keep track of the amount of funds contributed by each address.

    Token token;
    NFT nft;
    // Instances of the Token and NFT contracts.

    constructor() {
    // Constructor function that initializes instances of Token and NFT contracts.

        token = new Token();
        nft = new NFT();
    }

    // the function mint to the funder some erc20 and an erc721
    function fundMyProject() public payable {

        // Increases the amount funded by the sender's address.
        addressToAmountFunded[msg.sender] += msg.value;

        // Calls the 'mint' function of the Token contract to mint ERC20 tokens to the sender.
        token.mint(msg.sender, msg.value);

        // Calls the 'safeMint' function of the NFT contract to mint an ERC721 token to the sender.
        nft.safeMint(msg.sender);
    }

    // Function to withdraw funds from the contract.
    function withdraw(uint256 amount) public payable {

        // Transfers the specified amount of Ether to the sender.
        payable(msg.sender).transfer(amount);
    }

    // Function to get the address of the NFT contract.
    function nftAddress() public view returns (address) {
        return address(nft);
    }

    // Function to get the address of the Token contract.
    function tokenAddress() public view returns (address) {
        return address(token);
    }
}

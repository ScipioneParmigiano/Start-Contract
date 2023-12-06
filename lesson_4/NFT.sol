// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// Imports the ERC721 interface from the OpenZeppelin library. ERC721 is a standard for non-fungible tokens (NFTs).

contract NFT is ERC721 {
    // Defines the NFT contract, inheriting from the ERC721 standard.

    uint256 private _nextTokenId;
    // Private variable to keep track of the next token ID to be minted.

    constructor() ERC721("Non Fungible Token", "NFT") {}
    // Constructor function that initializes the ERC721 contract with the name "Non Fungible Token" and symbol "NFT".

    function _baseURI() internal pure override returns (string memory) {
      // Internal function to define the base URI for token metadata.

        return
            "https://ipfs.io/ipfs/QmcfkxKFRWwTSS23FEsf14jUPQRaVaZYPRG3f3jsXgJk1z?filename=uri_example.json";
    }

    function safeMint(address to) public {
    // Public function to safely mint a new token and assign it to the specified address.

        uint256 tokenId = _nextTokenId++;
        // Increment the token ID for the next minted token.

        _safeMint(to, tokenId);
        // Safely mints a new token and assigns it to the specified address.
    }
}

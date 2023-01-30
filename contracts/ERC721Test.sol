//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract ERC721Test is ERC721 {
    address public owner;
    constructor() ERC721("test_nft","NFT") {
        owner = msg.sender;
    }
    function mint(address to, uint256 tokenId) public {
        require(msg.sender == owner,"Not owner");
        _mint(to, tokenId);
    }
}
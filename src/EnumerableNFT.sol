// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721, ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

/**
 * @title MyNFT
 * @dev A contract to mint enumerable NFTs with a max supply and fixed price.
 */
contract MyNFT is ERC721Enumerable {

    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 20;
    uint256 public constant PRICE = 1 ether;

    event NFTsMinted(address indexed minter, uint256 amount);

    constructor() ERC721("MyNFT", "NFT") {}

    /**
     * @notice Mints a given amount of new NFTs for the sender.
     * @dev Checks that the total supply after minting does not exceed the max supply,
     * and that the correct ether value is sent.
     * @param amount The number of NFTs to mint.
     */
    function mint(uint256 amount) public payable {
        require(tokenSupply + amount <= MAX_SUPPLY, "Exceeds maximum supply");
        require(msg.value == PRICE * amount, "Ether value sent is not correct");
        
        for (uint256 i = 0; i < amount; i++) {
            _mint(msg.sender, tokenSupply);
            tokenSupply++;
        }

        emit NFTsMinted(msg.sender, amount);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
// import {ERC721, ERC721Enumerable} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

/**
 * @title GameNFT
 * @dev A contract to mint enumerable NFTs with a max supply and fixed price.
 */
contract GameNFT is ERC721Enumerable {

    uint256 private remainingSupply;
    uint256 private constant MAX_SUPPLY = 20;
    uint256 public constant PRICE = 1 ether;

    event NFTMinted(address indexed minter, uint256 indexed tokenId);

    constructor() ERC721("GameNFT", "GAME") {
        remainingSupply = MAX_SUPPLY;
    }

    /**
     * @notice Mints a given amount of new NFTs for the sender.
     * @dev Checks that the total supply after minting does not exceed the max supply,
     * and that the correct ether value is sent.
     * @param amount The number of NFTs to mint.
     */
    function mint(uint256 amount) public payable {
        require(remainingSupply >= amount, "Exceeds maximum supply");
        require(msg.value == PRICE * amount, "Ether value sent is not correct");
        
        uint256 toMint = amount;
        while (toMint > 0) {
            uint256 tokenId = MAX_SUPPLY - remainingSupply;
            _mint(msg.sender, tokenId);
            emit NFTMinted(msg.sender, tokenId);

            remainingSupply--;
            toMint--;
        }
    }

    /**
     * @notice Views the remaining supply of the NFTs.
     * @dev Provides a public way to check the remaining NFTs that can be minted.
     * @return The number of remaining NFTs that can be minted.
     */
    function getRemainingSupply() public view returns (uint256) {
        return remainingSupply;
    }
}

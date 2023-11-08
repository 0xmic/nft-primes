// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {IERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
// import {ERC721, ERC721Enumerable} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

/**
 * @title PrimeCounter
 * @dev A contract to count the number of NFTs with prime token IDs owned by a specific address.
 */
contract PrimeCounter {
    
    IERC721Enumerable private immutable _nft;

    /**
     * @notice Initializes the contract with an ERC721Enumerable contract's address.
     * @param nftAddress The address of the ERC721Enumerable contract.
     */
    constructor(address nftAddress) {
        _nft = IERC721Enumerable(nftAddress);
    }

    /**
     * @notice Counts the number of NFTs with prime IDs owned by a specific address.
     * @param owner The owner's address.
     * @return primeCount The number of NFTs with prime IDs owned by the given address.
     */
    function countPrimes(address owner) public view returns (uint256 primeCount) {
        primeCount = 0;
        uint256 balance = _nft.balanceOf(owner);

        for (uint256 i = 1; i < balance; i++) {
            uint256 tokenId = _nft.tokenOfOwnerByIndex(owner, i);
            if (isPrime(tokenId)) {
                primeCount++;
            }
        }

        return primeCount;
    }

    /**
     * @notice Checks if a given number is a prime number.
     * @param num The number to check.
     * @return result A boolean indicating whether the number is prime or not.
     */
    function isPrime(uint num) public pure returns (bool result) {
        if (num < 2) {
            result = false;
            return result;
        }

        result = true;

        for (uint i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                result = false;
                // break;
            }
        }

        return result;
    }
}

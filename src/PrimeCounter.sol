// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

/**
 * @title PrimeCounter
 * @dev A contract to count the number of NFTs with prime token IDs owned by a specific address.
 */
contract PrimeCounter {
    
    IERC721Enumerable private _nft;

    /**
     * @notice Initializes the contract with an ERC721Enumerable contract's address.
     * @param nftAddress The address of the ERC721Enumerable contract.
     */
    constructor(address nftAddress) {
        _nft = IERC721Enumerable(nftAddress);
    }

    /**
     * @notice Checks if a given number is a prime number.
     * @param num The number to check.
     * @return A boolean indicating whether the number is prime or not.
     */
    function isPrime(uint256 num) public pure returns (bool) {
        if (num < 2) {
            return false;
        }

        for (uint256 i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                return false;
            }
        }

        return true;
    }

    /**
     * @notice Counts the number of NFTs with prime IDs owned by a specific address.
     * @param owner The owner's address.
     * @return primeCount The number of NFTs with prime IDs owned by the given address.
     */
    function countPrimes(address owner) public view returns (uint256 primeCount) {
        primeCount = 0;
        uint256 balance = _nft.balanceOf(owner);

        for (uint256 i = 0; i < balance; i++) {
            uint256 tokenId = _nft.tokenOfOwnerByIndex(owner, i);
            if (isPrime(tokenId)) {
                primeCount++;
            }
        }

        return primeCount;
    }
}

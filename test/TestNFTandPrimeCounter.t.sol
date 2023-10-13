// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {Test, console2} from "forge-std/Test.sol";
import {StdCheats, console2} from "forge-std/StdCheats.sol";
import {GameNFT} from "../src/GameNFT.sol";
import {PrimeCounter} from "../src/PrimeCounter.sol";
import {DeployNFTandPrimeCounter} from "../script/DeployNFTandPrimeCounter.s.sol";

contract BondingCurveTokenTest is StdCheats, Test {
    GameNFT public gameNFT;
    PrimeCounter public primeCounter;
    DeployNFTandPrimeCounter public deployer;
    address public nftMinter;

    address public deployerAddress;

    function setUp() public {
        deployer = new DeployNFTandPrimeCounter();
        DeployNFTandPrimeCounter.ContractList memory contracts = deployer.run();
        gameNFT = contracts.gameNFT;
        primeCounter = contracts.primeCounter;
        deployerAddress = deployer.deployerAddress();
        
        nftMinter = makeAddr("nftMinter");
    }

    function test_NFTName() public {
        assertEq(gameNFT.name(), "GameNFT");
    }

    function test_PrimeCounter() public {
      // test isPrime with 2, 3, 5, 7, 11, 101
      assertEq(primeCounter.isPrime(2), true);
      assertEq(primeCounter.isPrime(3), true);
      assertEq(primeCounter.isPrime(5), true);
      assertEq(primeCounter.isPrime(11), true);
      assertEq(primeCounter.isPrime(101), true);

      assertEq(primeCounter.isPrime(4), false);
      assertEq(primeCounter.isPrime(12), false);
      assertEq(primeCounter.isPrime(27), false);
      assertEq(primeCounter.isPrime(63), false);
      assertEq(primeCounter.isPrime(100), false);
    }

    function test_countPrimes() public {
      hoax(nftMinter, 10 ether);

      // mint tokenIDs 1-10, primes: 2, 3, 5, 7
      gameNFT.mint{value: 10 ether}(10);
      assertEq(primeCounter.countPrimes(nftMinter), 4);
    }
}
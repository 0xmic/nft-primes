// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {GameNFT} from "../src/GameNFT.sol";
import {PrimeCounter} from "../src/PrimeCounter.sol";

contract DeployNFTandPrimeCounter is Script {
    // struct of deployed contracts
    struct ContractList {
        GameNFT gameNFT;
        PrimeCounter primeCounter;
    }

    uint256 public constant INITIAL_SUPPLY = 1_000_000 ether; // 1 million tokens with 18 decimal places
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;
    address public deployerAddress;
    bytes32 public merkleProof;
    ContractList public contractList;
    

    function run() external returns (ContractList memory contractlist) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }
        deployerAddress = vm.addr(deployerKey);

        vm.startBroadcast(deployerKey);
        GameNFT gameNFT = new GameNFT();
        PrimeCounter primeCounter = new PrimeCounter(address(gameNFT));
        vm.stopBroadcast();

        contractList = ContractList(gameNFT, primeCounter);
        return contractList;
    }
}
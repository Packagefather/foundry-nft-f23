// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract MintBasicNFT is Script {
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    uint256 deployerKey;

    function run() external {
        address mostRecentlyDeployedBasicNFT = DevOpsTools
            .get_most_recent_deployment("BasicNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployedBasicNFT);
    }

    function mintNFTOnContract(address basicNFTAddress) public {
        vm.startBroadcast();
        BasicNFT(basicNFTAddress).mintNFT(PUG_URI);
        vm.stopBroadcast();
    }
}

contract MintMoodNFT is Script {
    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNFTOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNFT(moodNftAddress).mintNFT();
        vm.stopBroadcast();
    }
}

contract FlipMoodNFT is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNFT", block.chainid);
        flipMoodNFT(mostRecentlyDeployedBasicNft);
    }

    function flipMoodNFT(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNFT(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
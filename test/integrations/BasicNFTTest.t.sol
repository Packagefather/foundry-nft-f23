// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
//import {MintBasicNft} from "../script/Interactions.s.sol";

contract BasicNftTest is StdCheats, Test {
    string constant NFT_NAME = "Fredie";
    string constant NFT_SYMBOL = "FREDO";
    BasicNFT public basicNFT;
    DeployBasicNFT public deployer;
    

    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    address public Alice = makeAddr("Alice");

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testInitializedCorrectly() public view{

        string memory expectedName = "Fredie";
        string memory expectedSymbol = "FREDO";
        string memory actualName = basicNFT.name();
        //assert(expectedName == actualName);
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));

        assert(
            keccak256(abi.encodePacked(basicNFT.symbol())) ==
                keccak256(abi.encodePacked((expectedSymbol)))
        );
    
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(Alice);
        basicNFT.mintNFT(PUG_URI);

        assert(basicNFT.balanceOf(Alice) == 1);
        
    }

    function testTokenURIIsCorrect() public {
        vm.prank(Alice);
        basicNFT.mintNFT(PUG_URI);

        assert(
            keccak256(abi.encodePacked(basicNFT.tokenURI(0))) ==
                keccak256(abi.encodePacked(PUG_URI))
        );
    }

    // function testMintWithScript() public {
    //     uint256 startingTokenCount = basicNft.getTokenCounter();
    //     MintBasicNft mintBasicNft = new MintBasicNft();
    //     mintBasicNft.mintNftOnContract(address(basicNft));
    //     assert(basicNft.getTokenCounter() == startingTokenCount + 1);
    // }
    
}
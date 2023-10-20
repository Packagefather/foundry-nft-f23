// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployMoodNFT} from "../../script/DeployMoodNFT.s.sol";
import {Test, console} from "forge-std/Test.sol";

contract MoodNFTTest is Test {
    DeployMoodNFT public deployer;

    function setUp() public {

        deployer = new DeployMoodNFT();
    }

    function testSVGToURI() public {
        string memory expectedURI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0iYmxhY2siPiBIaSEgWW91ciBicm93c2VyIGRlY29kZWQgdGhpczwvdGV4dD48L3N2Zz4=";
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="black"> Hi! Your browser decoded this</text></svg>';
       
        string memory actualURI = deployer.svgToImageURI(svg);
        assertEq(keccak256(abi.encodePacked(actualURI)), keccak256(abi.encodePacked(expectedURI)));

    }
}
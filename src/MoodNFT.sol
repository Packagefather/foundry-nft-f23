// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error MoodNFT__CantFlipMoodIfNotOwner();

    enum NFTMood {
        HAPPY,
        SAD
    }

    uint256 private s_tokenCounter;
    string private s_sadSvgUri;
    string private s_happySvgUri;

    mapping(uint256 => NFTMood) private s_tokenIdToMood;

    event CreatedNFT(uint256 indexed tokenId);

    constructor(
        string memory sadSvgUri,
        string memory happySvgUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgUri = sadSvgUri;
        s_happySvgUri = happySvgUri;
    }

    function mintNFT() public {
        
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, tokenCounter);
        s_tokenIdToMood[s_tokenCounter]=NFTMood.HAPPY;
        s_tokenCounter ++;
        emit CreatedNFT(tokenCounter);
    }

    function flipMood(uint256 tokenId) public {
        if (_ownerOf(tokenId) != msg.sender) {
            revert MoodNFT__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[tokenId] == NFTMood.HAPPY) {
            s_tokenIdToMood[tokenId] = NFTMood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = NFTMood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        // if (!_exists(tokenId)) {
        //     revert ERC721Metadata__URI_QueryFor_NonExistentToken();
        // }
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == NFTMood.SAD) {
            imageURI = s_happySvgUri;
        }else{
            imageURI = s_sadSvgUri;
        }
        
        return string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function getHappySVG() public view returns (string memory) {
        return s_happySvgUri;
    }

    function getSadSVG() public view returns (string memory) {
        return s_sadSvgUri;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {MoodNFT} from "../../src/MoodNFT.sol";
import {Test, console} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {MintBasicNFT} from "../../script/Interactions.s.sol";

contract MoodNFTTest is StdCheats, Test {
    string constant NFT_NAME = "Mood NFT";
    string constant NFT_SYMBOL = "MN";
    MoodNFT public moodNFT;

    string public constant HAPPY_MOOD_URI = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0ieWVsbG93IiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+CiAgPGcgY2xhc3M9ImV5ZXMiPgogICAgPGNpcmNsZSBjeD0iNjEiIGN5PSI4MiIgcj0iMTIiLz4KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPgogIDwvZz4KICA8cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctNjQuMTEgNDItODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IGJsYWNrOyBzdHJva2Utd2lkdGg6IDM7Ii8+Cjwvc3ZnPg==";

    string public constant SAD_MOOD_URI = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAyNHB4IiBoZWlnaHQ9IjEwMjRweCIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cGF0aCBmaWxsPSIjMzMzIiBkPSJNNTEyIDY0QzI2NC42IDY0IDY0IDI2NC42IDY0IDUxMnMyMDAuNiA0NDggNDQ4IDQ0OCA0NDgtMjAwLjYgNDQ4LTQ0OFM3NTkuNCA2NCA1MTIgNjR6bTAgODIwYy0yMDUuNCAwLTM3Mi0xNjYuNi0zNzItMzcyczE2Ni42LTM3MiAzNzItMzcyIDM3MiAxNjYuNiAzNzIgMzcyLTE2Ni42IDM3Mi0zNzIgMzcyeiIvPgogIDxwYXRoIGZpbGw9IiNFNkU2RTYiIGQ9Ik01MTIgMTQwYy0yMDUuNCAwLTM3MiAxNjYuNi0zNzIgMzcyczE2Ni42IDM3MiAzNzIgMzcyIDM3Mi0xNjYuNiAzNzItMzcyLTE2Ni42LTM3Mi0zNzItMzcyek0yODggNDIxYTQ4LjAxIDQ4LjAxIDAgMCAxIDk2IDAgNDguMDEgNDguMDEgMCAwIDEtOTYgMHptMzc2IDI3MmgtNDguMWMtNC4yIDAtNy44LTMuMi04LjEtNy40QzYwNCA2MzYuMSA1NjIuNSA1OTcgNTEyIDU5N3MtOTIuMSAzOS4xLTk1LjggODguNmMtLjMgNC4yLTMuOSA3LjQtOC4xIDcuNEgzNjBhOCA4IDAgMCAxLTgtOC40YzQuNC04NC4zIDc0LjUtMTUxLjYgMTYwLTE1MS42czE1NS42IDY3LjMgMTYwIDE1MS42YTggOCAwIDAgMS04IDguNHptMjQtMjI0YTQ4LjAxIDQ4LjAxIDAgMCAxIDAtOTYgNDguMDEgNDguMDEgMCAwIDEgMCA5NnoiLz4KICA8cGF0aCBmaWxsPSIjMzMzIiBkPSJNMjg4IDQyMWE0OCA0OCAwIDEgMCA5NiAwIDQ4IDQ4IDAgMSAwLTk2IDB6bTIyNCAxMTJjLTg1LjUgMC0xNTUuNiA2Ny4zLTE2MCAxNTEuNmE4IDggMCAwIDAgOCA4LjRoNDguMWM0LjIgMCA3LjgtMy4yIDguMS03LjQgMy43LTQ5LjUgNDUuMy04OC42IDk1LjgtODguNnM5MiAzOS4xIDk1LjggODguNmMuMyA0LjIgMy45IDcuNCA4LjEgNy40SDY2NGE4IDggMCAwIDAgOC04LjRDNjY3LjYgNjAwLjMgNTk3LjUgNTMzIDUxMiA1MzN6bTEyOC0xMTJhNDggNDggMCAxIDAgOTYgMCA0OCA0OCAwIDEgMC05NiAweiIvPgo8L3N2Zz4=";

    address public constant USER = address(1);

    function setUp() public {
        moodNFT = new MoodNFT(HAPPY_MOOD_URI, SAD_MOOD_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNFT.mintNFT();
        console.log(moodNFT.tokenURI(0));
    }
    // function testInitializedCorrectly() public view {
    //     assert(
    //         keccak256(abi.encodePacked(moodNFT.name())) ==
    //             keccak256(abi.encodePacked((NFT_NAME)))
    //     );
    //     assert(
    //         keccak256(abi.encodePacked(moodNft.symbol())) ==
    //             keccak256(abi.encodePacked((NFT_SYMBOL)))
    //     );
    // }

    // function testCanMintAndHaveABalance() public {
    //     vm.prank(USER);
    //     moodNft.mintNft();

    //     assert(moodNft.balanceOf(USER) == 1);
    // }

    // function testTokenURIDefaultIsCorrectlySet() public {
    //     vm.prank(USER);
    //     moodNft.mintNft();

    //     assert(
    //         keccak256(abi.encodePacked(moodNft.tokenURI(0))) ==
    //             keccak256(abi.encodePacked(HAPPY_MOOD_URI))
    //     );
    // }

    // function testFlipTokenToSad() public {
    //     vm.prank(USER);
    //     moodNft.mintNft();

    //     vm.prank(USER);
    //     moodNft.flipMood(0);

    //     assert(
    //         keccak256(abi.encodePacked(moodNft.tokenURI(0))) ==
    //             keccak256(abi.encodePacked(SAD_MOOD_URI))
    //     );
    // }

    // function testEventRecordsCorrectTokenIdOnMinting() public {
    //     uint256 currentAvailableTokenId = moodNft.getTokenCounter();

    //     vm.prank(USER);
    //     vm.recordLogs();
    //     moodNft.mintNft();
    //     Vm.Log[] memory entries = vm.getRecordedLogs();

    //     bytes32 tokenId_proto = entries[1].topics[1];
    //     uint256 tokenId = uint256(tokenId_proto);

    //     assertEq(tokenId, currentAvailableTokenId);
    // }
}
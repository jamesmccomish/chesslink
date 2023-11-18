// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {BasicTestConfig} from "./config/BasicTestConfig.t.sol";

import {Player} from "../src/Player.sol";

contract PlayerTest is BasicTestConfig {
    Player public player;

    string PLAYER_NAME = "Player 1";
    string TOKEN_0_URI = "https://token-store.com/0";
    string TOKEN_1_URI = "https://token-store.com/1";

    function setUp() public {
        string[] memory tokenUris = new string[](2);
        tokenUris[0] = TOKEN_0_URI;
        tokenUris[1] = TOKEN_1_URI;

        player = new Player(PLAYER_NAME, tokenUris);
    }

    function testSetupCorrectly() public {
        assertEq(player.name(), PLAYER_NAME, "Player name incorrect");
        assertEq(player.uri(0), TOKEN_0_URI, "Token 0 URI incorrect");
        assertEq(player.uri(1), TOKEN_1_URI, "Token 1 URI incorrect");
    }
}

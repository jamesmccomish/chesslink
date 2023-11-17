// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IPlayer} from "./interfaces/IPlayer.sol";

contract OpenfileChessBetting {
    /// -----------------------------------------------------------------------
    /// Game Storage
    /// -----------------------------------------------------------------------

    enum Result {
        DRAW,
        PLAYER_1_WIN,
        PLAYER_2_WIN
    }

    enum Status {
        PENDING, // The match has been deployed, but not confirmed by the players
        AUTHORIZED, // The players have confirmed and betting can begin
        ACTIVE, // The match is active and betting has stopped
        COMPLETED, // The match is over and a result is set
        CANCELLED // The match was cancelled and funds can be reclaimed
    }

    /// @notice Struct defining the match details
    // TODO track all betters on the match
    struct MatchDetails {
        IPlayer player1; // Player contract address of player 1
        IPlayer player2; // Player contract address of player 2
        uint256 totalStake;
        uint256 startTime;
        Status status;
        Result result;
        string description; // Description of the match
    }

    /// @notice Details for this match
    MatchDetails public matchDetails;

    /// @notice ID of the ERC1155 token representing ownership
    uint256 internal constant PLAYER_TOKEN_ID = 0;

    /// @notice ID of the ERC1155 token representing rewards
    uint256 internal constant REWARD_TOKEN_ID = 1;

    /**
     * @notice Mapping of each match's details
     * @dev The key is the hash of the players and start time: keccak256(abi.encodePacked(whitePlayerName, blackPlayerName, startTime))
     */
    mapping(bytes32 => MatchDetails) public matches;

    /// @notice Mapping of each player contract by hash of username
    mapping(bytes32 => address) public players;

    /// -----------------------------------------------------------------------
    /// Constructor
    /// -----------------------------------------------------------------------

    constructor() {
        // TODO
    }

    /// -----------------------------------------------------------------------
    /// Player Functions
    /// -----------------------------------------------------------------------

    /**
     * @notice Creates a new player contract
     * @param _name Name of the player
     * @param _tokenUris URIs of the tokens to mint
     */
    function createPlayer(string memory _name, string[] memory _tokenUris) public {
        // TODO
    }

    /// -----------------------------------------------------------------------
    /// Match Functions
    /// -----------------------------------------------------------------------

    // TODO create match

    // TODO settle match

    /// -----------------------------------------------------------------------
    /// Bet Functions
    /// -----------------------------------------------------------------------

    // TODO bet on match
}

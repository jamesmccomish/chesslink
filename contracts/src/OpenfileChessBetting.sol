// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IPlayer} from "./interfaces/IPlayer.sol";

import {OpenfileChessChainlinkFunction, FunctionsRequest} from "./OpenfileChessChainlinkFunction.sol";

contract OpenfileChessBetting is OpenfileChessChainlinkFunction {
    using FunctionsRequest for FunctionsRequest.Request;

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

    constructor(address _router, string memory _remoteCodeLocation, uint64 _subscriptionId)
        OpenfileChessChainlinkFunction(_router, _remoteCodeLocation, _subscriptionId)
    {
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
    /**
     * @notice Creates a new match
     * @param _whitePlayerName Name of the white player // ! limit on string length here
     * @param _blackPlayerName Name of the black player // ! limit on string length here
     * @param _startTime Start time of the match
     * @param _description Description of the match
     */
    function createMatch(
        string memory _whitePlayerName,
        string memory _blackPlayerName,
        uint256 _startTime,
        string memory _description
    ) public {
        // TODO call function to verify match is in play with current players

        FunctionsRequest.Request memory req;
        //req.init(format req);

        string[] memory args = new string[](1);
        args[0] = "1234";
        req.setArgs(args);

        // Send req to chainlink fn
        bytes32 assignedReqID = _sendRequest(req.encodeCBOR(), subscriptionId, 100000, "fun-polygon-mumbai-1"); // TODO fix gasLimit

        // Set match details as pending
    }

    function _createMatch(bytes32 matchId) internal {
        // TODO finish this

        matches[matchId].status = Status.ACTIVE;
    }

    /**
     * @notice Callback that is invoked once the DON has resolved the request or hit an error
     *
     * @param requestId The request ID, returned by sendRequest()
     * @param response Aggregated response from the user code
     * @param err Aggregated error from the user code or from the execution pipeline
     * Either response or error parameter will be set, but never both
     */
    function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal override {
        // TODO finish this & correct

        matches[keccak256(response)].status = Status.ACTIVE;
    }

    // TODO settle match

    /// -----------------------------------------------------------------------
    /// Bet Functions
    /// -----------------------------------------------------------------------

    // TODO bet on match
}

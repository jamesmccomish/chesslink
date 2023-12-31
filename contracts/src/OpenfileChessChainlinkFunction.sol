// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {FunctionsClient} from "../node_modules/@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/FunctionsClient.sol";
import {FunctionsRequest} from
    "../node_modules/@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/libraries/FunctionsRequest.sol";

/**
 * @title The Chainlink Functions client contract
 * @notice Calls a functions to check against lichess game
 * @author James McComish (inspired by chainlink-functions-demo-app)
 */
contract OpenfileChessChainlinkFunction is FunctionsClient {
    uint64 public subscriptionId;

    bytes32 public latestRequestId;
    bytes public latestResponse;
    bytes public latestError;

    // The code to run on the chainlink function
    string public inlineFunctionCode;

    constructor(address router, string memory _inlineFunctionCode, uint64 _subscriptionId) FunctionsClient(router) {
        inlineFunctionCode = _inlineFunctionCode;

        subscriptionId = _subscriptionId;
    }

    /// -----------------------------------------------------------------------
    /// UNSAFE OWNER FUNCTIONS (not restricted for demo purposes)
    /// -----------------------------------------------------------------------

    function setSubscriptionId(uint64 _subscriptionId) external {
        subscriptionId = _subscriptionId;
    }

    /// -----------------------------------------------------------------------
    /// CHAINLINK FUNCTIONS
    /// -----------------------------------------------------------------------

    function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal virtual override {
        latestResponse = response;
        latestError = err;
        //emit OCRResponse(requestId, response, err);
    }
}

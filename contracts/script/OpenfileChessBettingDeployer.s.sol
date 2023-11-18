// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {OpenfileChessBetting} from "../src/OpenfileChessBetting.sol";

import {Script, console2} from "../lib/forge-std/src/Script.sol";

import {FileReader} from "./FileReader.s.sol";

/**
 * @notice This contract deploys OpenfileChessBetting.sol
 * @dev We read the javascript function from a file using ffi and deploy the contract
 *      with the function logic and subscriptionId set
 */
contract OpenfileChessBettingDeployer is Script, FileReader {
    uint64 subscriptionId;

    string stringifiedFunctionLogic;

    OpenfileChessBetting public openfileChessBetting;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        stringifiedFunctionLogic = readJavascriptFunctionFile("get-current-game.js");

        console2.logString(stringifiedFunctionLogic);

        // TODO make variable from cmd args
        subscriptionId = 797;

        openfileChessBetting = new OpenfileChessBetting(
            address(0x6E2dc0F9DB014aE19888F539E59285D2Ea04244C), 
            stringifiedFunctionLogic,
            subscriptionId 
        );

        vm.stopBroadcast();
    }
}

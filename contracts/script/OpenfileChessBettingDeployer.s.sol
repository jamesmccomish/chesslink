// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {OpenfileChessBetting} from "../src/OpenfileChessBetting.sol";

import {Script, console2} from "../lib/forge-std/src/Script.sol";

import {FileReader} from "./FileReader.s.sol";

// TODO This hardcoding should be removed when correct stringify settings are applied to ffi reading the .js file
library TmpStrinifiedFunction {
    string public constant FUNCTION_STRING = 'const playerWhite = args[0]; const playerBlack = args[1];'
        'const formatLichessGameResponse = (data) => { '
        'const lines = data.split("\n"); let formattedDataObject = {}; lines.forEach(line => { '
        'if (line.trim() === "") { return; }; const [key, value] = line.slice(1, -1).split(" "); '
        'formattedDataObject[key] = value.replace(/"/g, ""); });   return formattedDataObject;} '
        'const lichessRequest = await Functions.makeHttpRequest({ '
        'url: `https://lichess.org/api/user/${playerWhite}/current-game`,}); if (lichessRequest.error) { '
        'throw new Error("Paraswap Request error"); }; '
        'const formattedDataObject = formatLichessGameResponse(await lichessRequest.data); '
        'if (formattedDataObject.Black != playerBlack) throw new Error("Invalid Game: Players dont match!"); '
        'return Functions.encodeString(formattedDataObject.Site.split("/").at(-1));';
}

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
        vm.startBroadcast(vm.envUint("MUMBAI_PRIVATE_KEY"));

        //stringifiedFunctionLogic = readJavascriptFunctionFile("get-current-game.js");
        stringifiedFunctionLogic = TmpStrinifiedFunction.FUNCTION_STRING;

        //console2.logString(stringifiedFunctionLogic);
        //revert("test");

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

// const playerWhite = args[0]; const playerBlack = args[1];
// const formatLichessGameResponse = (data) => {
// const lines = data.split("\n"); let formattedDataObject = {}; lines.forEach(line => {
// if (line.trim() === "") { return; }; const [key, value] = line.slice(1, -1).split(" ");
// formattedDataObject[key] = value.replace(/"/g, ""); });   return formattedDataObject;}
// const lichessRequest = await Functions.makeHttpRequest({
// url: `https://lichess.org/api/user/${playerWhite}/current-game`,}); if (lichessRequest.error) {
// throw new Error("Paraswap Request error"); };
// const formattedDataObject = formatLichessGameResponse(await lichessRequest.data);
// if (formattedDataObject.Black != playerBlack) throw new Error("Invalid Game: Players dont match!");
// return Functions.encodeString(formattedDataObject.Site.split("/").at(-1));

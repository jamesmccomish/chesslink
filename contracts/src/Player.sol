// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC1155} from "../lib/solbase/src/tokens/ERC1155/ERC1155.sol";

// TODO
// - Make ownable & eventually give owner to the player
// - Deploy as proxy rather than contract

contract Player is ERC1155 {
    /// -----------------------------------------------------------------------
    /// Player Storage
    /// -----------------------------------------------------------------------

    error NotFromOpenfileBetting();

    address public immutable openfileBetting;

    string public name;

    uint256 public constant PLAYER_SUPPORT_TOKEN = 0;

    uint256 public constant BET_REWARD_TOKEN = 1;

    /// @dev Internal ID metadata mapping.
    mapping(uint256 => string) internal _uris;

    /// -----------------------------------------------------------------------
    /// Constructor
    /// -----------------------------------------------------------------------

    constructor(address _openfileBetting, string memory _name, string[] memory _tokenUris) ERC1155() {
        openfileBetting = _openfileBetting;

        name = _name;

        // Set the initial token URIs
        for (uint256 i = 0; i < _tokenUris.length; i++) {
            _uris[i] = _tokenUris[i];
        }
    }

    /// -----------------------------------------------------------------------
    /// Mint/Burn Logic
    /// -----------------------------------------------------------------------

    /*
    * @notice Creates `amount` tokens of token type `id`, and assigns them to `to`.
    * @param to The address to mint tokens to.
    * @param id The token id to mint.
    * @param amount The amount of tokens to mint.
    * @param data
    */
    function mint(address to, uint256 id, uint256 amount, bytes calldata data) public payable virtual {
        // Users can mint the support token, but not the reward token
        // reward is delt with by the OpenfileBetting contract after a successful bet
        if (id != PLAYER_SUPPORT_TOKEN && msg.sender != openfileBetting) {
            revert NotFromOpenfileBetting();
        }

        _mint(to, id, amount, data);
    }

    /*
    * @notice Burns `amount` tokens of a given token ID from `from`.
    * @dev This is an internal function.
    * @param from Address to burn token from.
    * @param id Token ID to burn.
    * @param amount Amount of token to burn.
    */
    function burn(address from, uint256 id, uint256 amount) public payable virtual {
        if (msg.sender != from && !isApprovedForAll[from][msg.sender]) {
            revert Unauthorized();
        }

        _burn(from, id, amount);
    }

    /// -----------------------------------------------------------------------
    /// Uri Functinos
    /// -----------------------------------------------------------------------

    // TODO this should really be locked to the owner of the contract in future
    function setUri(uint256 id, string memory _uri) public {
        //require(msg.sender == openfileBetting, "Not from OpenfileBetting");

        _uris[id] = _uri;
    }

    /*
    * @notice Returns the URI for a given token ID.
    * @param id The ID of the token to query.
    * @return The URI for the given token ID.
    */
    // TODO format token id
    function uri(uint256 id) public view override returns (string memory) {
        return _uris[id];
    }

    function playerInfo() public view returns (string memory, string memory) {
        return (name, _uris[0]);
    }
}

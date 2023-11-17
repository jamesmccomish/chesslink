// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC1155} from "../lib/solbase/src/tokens/ERC1155/ERC1155.sol";

// TODO
// ! Add a limit to minting
// - Make ownable & eventually give owner to the player
// - Deploy as proxy

contract Player is ERC1155 {
    /// -----------------------------------------------------------------------
    /// Player Storage
    /// -----------------------------------------------------------------------

    string public name;

    /// @dev Internal ID metadata mapping.
    mapping(uint256 => string) internal _uris;

    /// -----------------------------------------------------------------------
    /// Constructor
    /// -----------------------------------------------------------------------

    constructor(string memory _name, string[] memory _tokenUris) ERC1155() {
        name = _name;

        // Set the initial token URIs
        for (uint256 i = 0; i < _tokenUris.length; i++) {
            _uris[i] = _tokenUris[i];
        }
    }

    /// -----------------------------------------------------------------------
    /// Mint/Burn Logic
    /// -----------------------------------------------------------------------

    // ! TODO limit this function
    /*
    * @notice Creates `amount` tokens of token type `id`, and assigns them to `to`.
    * @dev This is an internal function.
    * @param to The address to mint tokens to.
    * @param id The token id to mint.
    * @param amount The amount of tokens to mint.
    * @param data
    */
    function mint(address to, uint256 id, uint256 amount, bytes calldata data) public payable virtual {
        _mint(to, id, amount, data);
    }

    // TODO add mint function to mint tokens based on winning bet

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
    /// View Functinos
    /// -----------------------------------------------------------------------

    /*
    * @notice Returns the URI for a given token ID.
    * @param id The ID of the token to query.
    * @return The URI for the given token ID.
    */
    // TODO format token id
    function uri(uint256 id) public view override returns (string memory) {
        return _uris[id];
    }
}

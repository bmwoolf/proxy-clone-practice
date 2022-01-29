// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetFixedSupplyUpgradeable.sol";

contract NaiveFactory {
    function createToken(string calldata name, string calldata symbol, uint256 initialSupply) external returns (address) {
        // create new instance of the token contract
        ERC20PresetFixedSupplyUpgradeable token = new ERC20PresetFixedSupplyUpgradeable();
        // create the token from it, passing in the custom parameters
        token.initialize(name, symbol, initialSupply, msg.sender);

        // return its new token address
        return address(token);
    }
}
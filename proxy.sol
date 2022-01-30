// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetFixedSupplyUpgradeable.sol";
import "@openzeppelin/contracts/proxy/";

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


contract ProxyFactory {
    address immutable tokenImplementation;

    constructor() public {
        tokenImplementation = address(new ERC20PresetFixedSupplyUpgradeable());
    }
    /// PLUS: we don't need to deploy a new erc20 every time
    /// MINUS: we need to deploy a new proxy every time- which is cheaper than Naive Factory, but still more than a clone
    function createToken(string calldata name, string calldata symbol, uint256 initialSupply) external returns (address) {
        UpgradeableProxy proxy = new UpgradeableProxy(
            tokenImplementation,
            abe.encodeWithSelector(ERC20PresetFixedSupplyUpgradeable(0).initialize.selector, name, symbol, initialSupply, msg.sender)
        );

    }
}
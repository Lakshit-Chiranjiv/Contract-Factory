// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Pulls in OpenZeppelin's ERC20 implementation. It already contains balances,
// transfer, approve, transferFrom, allowance, and the Transfer/Approval events.
// We only add the "fixed supply" behaviour on top of it.
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// "is ERC20" means our contract inherits every function and state variable of ERC20.
contract FixedSupplyToken is ERC20 {

    // The entire supply of the token, in the smallest unit.
    // ERC20 uses 18 decimals, so 1 whole token = 10**18 units.
    // 1_000_000 * 10**18 therefore means one million whole tokens.
    // "constant" means the value is baked into the bytecode and can never change.
    // "public" makes the compiler auto-generate a getter function for it.
    uint256 public constant TOTAL_SUPPLY = 1_000_000 * 10 ** 18;

    // Runs exactly once, at the moment the contract is deployed, and never again.
    // The ERC20(...) call after the parentheses passes the token's name and symbol
    // to the parent constructor, which stores them.
    constructor() ERC20("Fixed Supply Token", "FST") {

        // Creates TOTAL_SUPPLY units and credits them to msg.sender, which inside a
        // constructor is the address that deployed the contract.
        // This is the only place _mint is called. Since the constructor can't run
        // again and we expose no other function that calls _mint, the total supply
        // is permanently fixed at this number.
        _mint(msg.sender, TOTAL_SUPPLY);
    }
}
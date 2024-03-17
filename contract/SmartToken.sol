
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {ERC20Votes} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {Nonces} from "@openzeppelin/contracts/utils/Nonces.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract SmartToken is ERC20, ERC20Permit, ERC20Votes, AccessControl {

    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    constructor() ERC20("SmartToken", "SMT")
        ERC20Permit("SmartToken")
    {
        // Grant the contract deployer the default admin role: it will be able
        // to grant and revoke any roles
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }

    function _update(address from, address to, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._update(from, to, amount);
    }

    function nonces(address owner) public view virtual override(ERC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }

    function approve(address _spender, uint256 _value)
        public override(ERC20)
        returns (bool)
    {
        return super.approve(_spender, _value);
    }
}
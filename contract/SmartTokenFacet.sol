// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import{AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
contract SmartTokenFacet is AccessControl, Pausable {

  bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
  IERC20 internal smts;

  constructor(address smts_) {
    _grantRole(PAUSER_ROLE, msg.sender);
    smts = IERC20(smts_);
  }

  function getToken() external returns (bool) {
      require(smts.balanceOf(address(this)) >= 20, "Insufficient balance in the faucet");
      smts.transfer(msg.sender, 20 ether);
      return true;
  }

  function balanceOf() external view returns (uint256){
    return smts.balanceOf(address(this));
  }

  function pause() external {
    require(hasRole(PAUSER_ROLE, msg.sender), "caller must be pauser");
    smts.transfer(msg.sender, smts.balanceOf(address(this)));
    _pause();
  }
  
  function unpause() external {
    require(hasRole(PAUSER_ROLE, msg.sender), "caller must be pauser");
    _unpause();
  }

}
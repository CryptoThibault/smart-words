//SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "./CustomNFT.sol";

contract SmartWords {
  mapping(address => CustomNFT[]) private _nfts;

  function _deployNFT(address owner) private {
    bytes32 newId = keccak256();
    _nfts[owner].push(new CustomNFT(owner, newId));
  }
}
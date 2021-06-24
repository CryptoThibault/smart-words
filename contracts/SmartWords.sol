//SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "./CustomNFT.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SmartWords is AccessControl {
  mapping(address => mapping(uint => CustomNFT)) private _nfts;
  mapping(uint => address) private _nftOwners;
  uint private _countId;

  function addressNftOf(address owner, uint id) public view returns (address) {
    return address(_nfts[owner][id]);
  }

  function addressNftOwner(uint id) public view returns (address) {
    return _nftOwners[id];
  }

  function codeNftOf(address owner, uint id) public view returns (bytes32) {
    return _nfts[owner][id].code();
  }

  function textNftOf(address owner, uint id) public view returns (string memory) {
    return _nfts[owner][id].text();
  }

  function _deployNFT(address owner, string memory text) private {
    _nfts[owner][_countId] = new CustomNFT(owner, _countId, text);
    _nftOwners[_countId] = owner;
    _countId++;
  }
}
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppellin/contracts/token/ERC721/ERC721.sol";

contract CustomNFT is ERC721 {
  constructor(address owner, uint id) ERC721("Words token", "WRD") {
    _mint(owner, id);
  }
}
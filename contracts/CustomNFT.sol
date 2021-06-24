//SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CustomNFT is ERC721 {
  bytes32 private _code;
  string private _text;
  constructor(address owner, uint id, string memory text_) ERC721("Words token", "WRD") {
    _mint(owner, id);
    _code = keccak256("CODE");
    _text = text_;
  }

  function code() public view returns (bytes32) {
    return _code;
  }

  function text() public view returns (string memory) {
    return _text;
  }
}
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

struct Text {
  string text;
  address author;
  uint timestamp;
  bytes32 key;
}

contract SmartWords is ERC721, AccessControl {
  mapping(uint => Text) private _texts;
  uint private _id;

  constructor() ERC721("Words Token", "WRD") {
    
  }
  
  modifier onlyTextOwner(uint id) {
    require(msg.sender == ownerOf(id), "SmartWords: function reserved to owner of this text");
    _;
  }

  function textContent(uint id_) public view returns(string memory) {
    return _texts[id_].text;
  }
  function textAuthor(uint id_) public view returns(address) {
    return _texts[id_].author;
  }
  function textOwner(uint id_) public view returns(address) {
    return ownerOf(id_);
  }
  function textTimestamp(uint id_) public view returns (uint) {
    return _texts[id_].timestamp;
  }
  function textKey(uint id_) public view returns(bytes32) {
    return _texts[id_].key;
  }



  function write(string memory text_) public {
    _mint(msg.sender, _id);
    _createText(_id, text_);
    _id++;
  }

  function edit(uint id_, string memory text_) public onlyTextOwner(id_) {
    _createText(id_, text_);
  }

  function _createText(uint id_, string memory text_) private {
    _texts[id_] = Text({
      text: text_,
      author: msg.sender,
      timestamp: block.timestamp,
      key: keccak256("KEY")
    });
  }
}
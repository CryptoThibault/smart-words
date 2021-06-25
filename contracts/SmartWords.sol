//SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

struct Text {
  string text;
  address author;
  uint timestamp;
  uint id;
  bytes32 key;
}

contract SmartWords is ERC721 {
  mapping(address => mapping(uint => uint)) private _textsId;
  mapping(uint => Text) private _textsData;
  uint private _countId;

  constructor() ERC721("Words Token", "WRD") {
    
  }
  function nftCreated() public view returns (uint) {
    return _countId;
  }
  function idOf(address owner, uint position) public view returns (uint) {
    require(position != 0, "SmartsWords: cannot read at position 0");
    return _textsId[owner][position];
  }
  function textOf(address owner, uint position) public view returns (Text memory) {
    return _textsData[idOf(owner, position)];
  }
  function textContentOf(address owner, uint position) public view returns (string memory) {
    return _textsData[idOf(owner, position)].text;
  }
  function textAuthorOf(address owner, uint position) public view returns (address) {
    return _textsData[idOf(owner, position)].author;
  }
  function textTimestampOf(address owner, uint position) public view returns (uint) {
    return _textsData[idOf(owner, position)].timestamp;
  }
  function textKeyOf(address owner, uint position) public view returns(bytes32) {
    return _textsData[idOf(owner, position)].key;
  }

  function write(string memory text, uint position) public returns (bool) {
    require(position != 0, "SmartsWords: cannot write at position 0");
    require(_textsId[msg.sender][position] == 0, "SmartsWords: position already have a text");
    _countId++;
    _createText(msg.sender, position, text, _countId);
    _mint(msg.sender, _countId);
    return true;
  }

  function transferOwnership(address newOwner, uint position) public returns (bool) {
    require(msg.sender == ownerOf(idOf(msg.sender, position)), "SmartsWords: sender is not owner of this nft");
    uint id = idOf(msg.sender, position);
    _textsId[msg.sender][position] = 0;
    _textsId[newOwner][balanceOf(newOwner) + 1] = id;
    _transfer(msg.sender, newOwner, id);
    return true;
  }

  function changePosition(address owner, uint position, uint newPosition) public returns (bool) {
    uint id = idOf(owner, position);
    _textsId[msg.sender][position] = 0;
    _textsId[msg.sender][newPosition] = id;
    return true;
  }

  function _createText(address sender, uint position, string memory text, uint id) private returns (bool) {
    _textsId[sender][position] = id;
    _textsData[id] = Text({
      text: text,
      author: sender,
      timestamp: block.timestamp,
      id: id,
      key: keccak256("KEY")
    });
    return true;
  }
}
const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('SmartsWords', async function () {
  let SmartWords, smartWords, dev, alice;
  const NAME = 'Words Token';
  const SYMBOL = 'WRD';
  const TITLE = 'Test String';
  const TEXT = 'Hello World!';
  const POSITION = 1;
  beforeEach(async function () {
    [dev, alice] = await ethers.getSigners();
    SmartWords = await ethers.getContractFactory('SmartWords');
    smartWords = await SmartWords.connect(dev).deploy();
    await smartWords.deployed();
  });
  it('should be the good name', async function () {
    expect(await smartWords.name()).to.equal(NAME);
  });
  it('should be the good symbol', async function () {
    expect(await smartWords.symbol()).to.equal(SYMBOL);
  });
  describe('Write', async function () {
    beforeEach(async function () {
      await smartWords.connect(alice).write(TITLE, TEXT, POSITION);
    });
    it('should asign id of the struct at good position', async function () {
      expect(await smartWords.idOf(alice.address, POSITION)).to.equal(await smartWords.nftCreated());
    });
    it('should asign good title at struct', async function () {
      expect(await smartWords.textTitleOf(alice.address, POSITION)).to.equal(TITLE);
    });
    it('should asign good text content at struct', async function () {
      expect(await smartWords.textContentOf(alice.address, POSITION)).to.equal(TEXT);
    });
    it('should asign good author at struct', async function () {
      expect(await smartWords.textAuthorOf(alice.address, POSITION)).to.equal(alice.address);
    });
    it('should asign good timestamp at struct', async function () {
      expect(await smartWords.textTimestampOf(alice.address, POSITION)).to.above(1);
    });
    it('should mint good amount of nft', async function () {
      expect(await smartWords.balanceOf(alice.address)).to.equal(1);
    });
    it('should mint nft for good user', async function () {
      expect(await smartWords.ownerOf(1)).to.equal(alice.address);
    });
  });
  describe('Transfer Ownership', async function () {});
  describe('Change Position', async function () {});
});

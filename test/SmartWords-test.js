const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('SmartsWords', async function () {
  let SmartWords, smartWords, dev, alice, bob;
  const NAME = 'Words Token';
  const SYMBOL = 'WRD';
  beforeEach(async function () {
    [dev, alice, bob] = await ethers.getSigners();
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
  describe('Write', async function () {});
  describe('Transfer Ownership', async function () {});
  describe('Change Position', async function () {});
});

const hre = require('hardhat');
const { deployed } = require('./deployed');

async function main() {
  const SmartWords = await hre.ethers.getContractFactory('SmartWords');
  const smartWords = await SmartWords.deploy();
  await smartWords.deployed();
  await deployed('SmartWords', hre.network.name, smartWords.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
// const hre = require("hardhat");
const { ethers, deployments,getNamedAccounts } = require("hardhat");

async function main() {
  // const ERC1271Test = await hre.ethers.getContractFactory("ERC1271Test");
  // const erc1271 = await ERC1271Test.deploy();
  // await erc1271.deployed();
  // console.log(erc1271.address)
  const { deployer } = await getNamedAccounts()
  // const [deployer] = await ethers.getSigners();
  // console.log(deployer)
  // return
  const { address } = await deployments.deploy('ERC1271Test', {
    from: deployer,
    contract: 'ERC1271Test'
  });
  console.log(`ERC1271Test deployed to ${address}`);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

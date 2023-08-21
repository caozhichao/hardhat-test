const { expect } = require("chai");
const { loadFixture } = require("ethereum-waffle");
const { ethers } = require("hardhat");
// require("dotenv").config()
const erc1271TestInfo = require('../deployments/goerli/ERC1271Test.json')
describe("ERC1271", function () {

  let erc1271Test;

  function deploy() {
    console.log('deploy')
  }

  function deploy2() {
    const ifac = new ethers.utils.Interface(erc1271TestInfo.abi)
    const provider = new ethers.providers.StaticJsonRpcProvider(process.env.GOERLI_RPC_URL)
    const wallet = new ethers.Wallet(process.env.DEPLOYER_KEY,provider)
    erc1271Test = new ethers.Contract(erc1271TestInfo.address,ifac,wallet)
  }

  it("isValidSignature selector", async function () {
    console.log('isValidSignature',process.env.GOERLI_RPC_URL)

    await loadFixture(deploy2)
    // // console.log(await erc1271Test.test())
    const tx = await erc1271Test.setV(20)
    await tx.wait()
    console.log(await erc1271Test.v())

    // await loadFixture(deploy)
    // console.log(await deployer.getAddress())
    // const ERC1271Test = await ethers.getContractFactory("ERC1271Test");
    // const c = await ERC1271Test.deploy();
    // await c.deployed();

    // console.log(await c.test())
    // const tx = await c.setV(10)
    // await tx.wait()
    // expect(await greeter.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

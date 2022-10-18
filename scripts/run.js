const { ConstructorFragment } = require("ethers/lib/utils");
const { ethers } = require("hardhat");

const main = async () => {
   const [owner, randomaddress] = await ethers.getSigners();
   const domainContract = await ethers.getContractFactory("Domains");
   const deployContract = await domainContract.deploy("ninja");

   await deployContract.deployed();

   console.log("Contract Address ", deployContract.address);

   let txn = await deployContract.register("beast", { value: ethers.utils.parseEther('0.1') });

   await txn.wait();


   console.log("Owner of domain beast ", await deployContract.getAddress("beast"));
   let balance = await ethers.provider.getBalance(deployContract.address);
   console.log("Contract Balance :", balance);

   balance = await hre.ethers.provider.getBalance(owner.address);

   console.log("Owner Balance :", balance);

   console.log("Contract Owner :",await deployContract.owner())


   const txn_withdraw = await deployContract.connect(owner).withdraw();

   await txn_withdraw.wait();

   

   balance = await hre.ethers.provider.getBalance(owner.address);

   console.log("Owner Balance :", balance);



};

const runMain = async () => {
   try {
      await main();
      process.exit(0);
   } catch (error) {
      console.log(error);
      process.exit(1);
   }
};

runMain();

 //   
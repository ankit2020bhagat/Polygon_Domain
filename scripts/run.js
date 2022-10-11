const { ethers } = require("hardhat");

const main = async () => {
    const [owner,randomaddress] = await ethers.getSigners();
    const domainContract = await ethers.getContractFactory("Domains");
    const deployContract  = await domainContract.deploy("ninja") ;

    await deployContract.deployed();

    console.log("Contract Address ",deployContract.address);

    let txn = await deployContract.register("beast",{value :  ethers.utils.parseEther('0.1')});

    await txn.wait();
    

    console.log("Owner of domain beast ",await deployContract.getAddress("beast"));

     const balance = await ethers.provider.getBalance(deployContract.address);
     console.log("Contract Balance :",balance);

};

const runMain = async() =>{
   try{
    await main();
    process.exit(0);
   } catch(error){
    console.log(error);
    process.exit(1);
   }
};

runMain();


const {ethers} = require("hardhat");

const main = async() => {
    const domainContract = await ethers.getContractFactory("Domains");
    const deployContract = await domainContract.deploy("ninja");
    await deployContract.deployed();

    console.log("Contract deployed to :",deployContract.address);
    
//     let txn_register = await deployContract.register("beast",{value : ethers.utils.parseEther('0.1')});

//     await txn_register.wait();

//     console.log("Minted domain beast.ninja");

//     txn = await deployContract.setRecord("beast", "Am I a beast or a ninja??");
//     await txn.wait();
//     console.log("Set record for beast.ninja");

//     console.log("owner of domain beast ",await deployContract.getAddress("beast"));
//     const balance = await ethers.provider.getBalance(deployContract.address);
//     console.log("Contract Balance :",balance);
 }
const runMain = async () =>{
    try{
        await main();
        process.exit(0);

    }catch(error){
        console.log(error);
        process.exit(1);
    }
}
runMain();
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");

require('dotenv').config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  paths: {
    artifacts: './domain-starter/src/artifacts',
  },
  networks: {
     mumbai: {
      url: process.env.MUMBAI_API_KEY_URL,
      accounts: [process.env.PRIVATE_KEY],
      },
      goerli: {
        url:  process.env.GOERLI_API_KEY_URL,
        accounts: [process.env.PRIVATE_KEY],
       
      },
      hardhat:{
        chainId:31337,
    },
   
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "C69P9MZEMUHNW8U7KQFET5RNZ1J9FWU1R8",
  }
 
};

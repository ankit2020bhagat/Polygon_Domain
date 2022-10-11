require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    // mumbai: {
    //   url: "https://polygon-mumbai.g.alchemy.com/v2/Xn6_UT4h8ipZUI5IsHXA-1pE-FOWIL-2",
    //   accounts: ["a4ccf5962d34ea2d1b202f57a0bf331e7114ce4e9eca8eec87a1049ed331804d"],
    // },
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/GFg7TsPqZV0ZaIxRgWrGRJDEaEvkvyA0",
      accounts: ["093da99a97487abdf1a45677fd60b8fe156fc3d4bf0e64a2648d032e60c57fc3"]
    },
  }
};

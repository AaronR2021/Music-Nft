
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");

require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    sepolia: {
      url: process.env.ALCHEMY_RPC_URL,//! create a connection between our app and blockchain
      accounts: [`0x${process.env.WALLET_PRIVATE_KEY}`],//! is the account that will deploy the contract
    },
  },

  // We don't need following ethescan block for deployment, but we need it for smart contract verification (upload).
  etherscan: {
    apiKey: process.env.NEXT_PUBLIC_ETHERSCAN_API_KEY,//!is to verify our contract
  },
};
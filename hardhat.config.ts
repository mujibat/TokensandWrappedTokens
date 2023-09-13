import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import 'dotenv'
require('dotenv').config()
const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    hardhat: {
      forking: {
        url: process.env.MAINNETRPC!,
      }
    },
    mainnet: {
      url: process.env.MAINNETRPC,
      //@ts-ignore
      accounts: [process.env.PRIVATEKEY],
    },
  },
  // etherscan: {
  //   // Your API key for Etherscan
  //   // Obtain one at https://etherscan.io/
  //   apiKey: process.env.BASE_API_KEY,
  // },
};

export default config;





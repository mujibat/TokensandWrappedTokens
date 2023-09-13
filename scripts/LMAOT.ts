import { ethers } from "hardhat";

async function main() {

  const lmao = await ethers.deployContract("LMAOToken", []);
  const wlmao = await ethers.deployContract("WrappedLMAOToken", []);

  await lmao.waitForDeployment();

  await wlmao.waitForDeployment();
  console.log(
    ` Deployed to ${lmao.target}`
  );
  console.log(
    ` Deployed to ${wlmao.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

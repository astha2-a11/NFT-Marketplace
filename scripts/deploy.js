const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contract with the account:", deployer.address);

  const CryptoCovenant = await hre.ethers.getContractFactory("CryptoCovenant");

  const beneficiary = "0x000000000000000000000000000000000000dead"; // Replace with actual address
  const unlockTime = Math.floor(Date.now() / 1000) + 3600; // 1 hour from now
  const assetDetails = "100 ETH to John Doe";

  const contract = await CryptoCovenant.deploy(beneficiary, unlockTime, assetDetails);
  await contract.deployed();

  console.log("CryptoCovenant deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

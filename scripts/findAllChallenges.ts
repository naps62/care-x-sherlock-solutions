import type { Setup } from "../typechain-types";

import { ethers } from "hardhat";

async function main() {
  const logs = await ethers.provider.getLogs({
    fromBlock: 6350500,
    toBlock: 6380500,
    topics: [
      "0xf40fcec21964ffb566044d083b4073f29f7f7929110ea19e1b3ebe375d89055e",
    ],
  });

  const data = logs.map(({ transactionHash, address, data }) => {
    return {
      hash: transactionHash,
      setup: address,
      challenge: ethers.utils.defaultAbiCoder.decode(["address"], data)[0],
    };
  });

  // console.table(data);
  console.log(`"Txhash","ContractAddress","ContractName"`);
  data.map(({ hash, setup, challenge }, i) => {
    console.log(`${hash},${setup},Setup #${i}`);
  });

  data.map(({ hash, setup, challenge }, i) => {
    console.log(`${hash},${challenge},Challenge #${i}`);
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

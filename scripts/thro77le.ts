import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import * as eth from "ethereumjs-util";

const { keccak256, id, hexConcat, getCreate2Address } = ethers.utils;

async function main() {
  const factoryAddr = "0xFD4f30C20dA65a37fd74d55B257442a08469e6A6";
  const contract = await ethers.getContractFactory("Thro77le_Foo");

  // const code = await ethers.provider.getCode(factoryAddr);
  // // CREATE2 params
  // const encodedArgs = contract.interface.encodeDeploy([]);
  // const code = hexConcat([contract.bytecode, encodedArgs]);

  // derive CREATE2 address used for the vault
  // let i = 0;
  // let valid = true;
  // let salt = id(BigNumber.from("0").toString());
  // let codehash =
  //   "4670da3f633e838c2746ca61c370ba3dbd257b86b28b78449f4185480e2aba51";
  // let address = getCreate2Address(factoryAddr, salt, code);
  // console.log("salt\n", salt);
  // console.log("address\n", address);
  // console.log("codehash\n", keccak256(code));

  // 0xff ++ deployingAddress is fixed:
  var string1 = "0xFD4f30C20dA65a37fd74d55B257442a08469e6A6";

  // Hash of the bytecode is fixed. Calculated with eth.keccak256():
  var string2 =
    "4670da3f633e838c2746ca61c370ba3dbd257b86b28b78449f4185480e2aba51";

  const code =
    "0x608060405234801561001057600080fd5b5061015d806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c806306fdde031461003b5780637872ab4914610059575b600080fd5b61004361009d565b6040518082815260200191505060405180910390f35b61009b6004803603602081101561006f57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506100c5565b005b60007f736d617278000000000000000000000000000000000000000000000000000000905090565b8073ffffffffffffffffffffffffffffffffffffffff1663380c7a676040518163ffffffff1660e01b8152600401600060405180830381600087803b15801561010d57600080fd5b505af1158015610121573d6000803e3d6000fd5b505050505056fea265627a7a72315820fb2fc7a07f0eebf799c680bb1526641d2d905c19393adf340a04e48c9b527de964736f6c634300050c0032";
  console.log(keccak256(code));
  const initCodeHash =
    "0x4670da3f633e838c2746ca61c370ba3dbd257b86b28b78449f4185480e2aba51";

  // In each loop, i is the value of the salt we are checking
  for (var i = 0; i < 720575940379279; i++) {
    // 1. Convert i to hex, and it pad to 32 bytes:
    var saltToBytes = i.toString(16).padStart(64, "0");

    let address = getCreate2Address(
      factoryAddr,
      `0x${saltToBytes}`,
      initCodeHash
    );

    // 2. Concatenate this between the other 2 strings
    var concatString = string1.concat(saltToBytes).concat(string2);

    // 3. Hash the resulting string
    var hashed = eth.bufferToHex(eth.keccak256(Buffer.from(concatString)));

    // 4. Remove leading 0x and 12 bytes
    // 5. Check if the result contains badc0de
    if (address.match(/.{4}/g)!.includes("f0b1d")) {
      console.log(i);
      console.log(address);
      break;
    }
  }
  // do {
  //   salt = id(BigNumber.from(i.toString()).toString());

  //   address = getCreate2Address(factoryAddr, salt, keccak256(code));

  //   valid = !address.toString().toLowerCase().includes("f0b1d");
  //   i++;
  // } while (valid);
  // console.log("i", i);
  // console.log("salt\n", salt);
  // console.log("address\n", address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

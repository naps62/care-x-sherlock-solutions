import { ethers } from "hardhat";
import { BigNumber } from "ethers";

const { keccak256, id, hexConcat, getCreate2Address } = ethers.utils;

async function main() {
  const factoryAddr = "0xFD4f30C20dA65a37fd74d55B257442a08469e6A6";
  const contract = await ethers.getContractFactory("Thro77le_Foo");

  const code = await ethers.provider.getCode(factoryAddr);
  // CREATE2 params
  const encodedArgs = contract.interface.encodeDeploy([]);
  // const code = hexConcat([contract.bytecode, encodedArgs]);

  // derive CREATE2 address used for the vault
  let i = 0;
  let valid = true;
  let salt = "0"; //id(BigNumber.from("0").toString());
  let address = getCreate2Address(factoryAddr, salt, keccak256(code));
  console.log(address);
  do {
    salt = id(BigNumber.from(i.toString()).toString());

    address = getCreate2Address(factoryAddr, salt, keccak256(code));

    valid = !address.toString().toLowerCase().includes("f0b1d");
    i++;
  } while (valid);
  console.log(i);
  console.log(salt);
  console.log(address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

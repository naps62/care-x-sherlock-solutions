// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_hack3r0m {
    function encFlag() external view returns (bytes memory);

    function encryptFlag(string memory) external pure returns (bytes memory);
}

contract Exploit_hack3r0m {
    IChallenge_hack3r0m instance;

    bytes public constant encFlag = bytes(hex"6e3c5b0f722c430e6d324c0d6f67173d4b1565345915753504211f");

    constructor(IChallenge_hack3r0m _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        bytes memory flag = instance.encFlag();

        test();
        // for(uint256 i; i < flag.length; ++i) {
        //     flag[i]

        // }

        // instance.solveIt(decFlag);
    }

    // TODO probably reverse this?
    function test() public view {
        bytes memory flag = bytes(hex"00ff");
        for (uint256 i; i < flag.length; i++) {
            if (i > 0) flag[i] ^= flag[i - 1];
            flag[i] ^= flag[i] >> 4;
            flag[i] ^= flag[i] >> 3;
            flag[i] ^= flag[i] >> 2;
            flag[i] ^= flag[i] >> 1;
            console.log(uint8(flag[i]));
        }
    }

    receive() external payable {}
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_hack3r0m {
    function solveIt(string memory) external;
}

contract Exploit_hack3r0m {
    IChallenge_hack3r0m instance;

    constructor(IChallenge_hack3r0m _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        string memory flag = string(bytes(hex"534845524C4F434B5F4354465F3078305F57494E4E45525F333333"));

        instance.solveIt(flag);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_kuldeep23907 {
    function guess(uint256 n) external payable;
}

interface ISloganProxy_kuldeep23907 {}

interface ILollercoaster_kuldeep23907 {
    function randInt(uint256 n) external view returns (uint256);
}

contract Exploit_kuldeep23907 {
    IChallenge_kuldeep23907 instance;

    constructor(IChallenge_kuldeep23907 _instance) payable {
        instance = _instance;
    }

    function finalize() external {
        selfdestruct(payable(msg.sender));
    }
}

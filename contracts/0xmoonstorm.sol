// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_0xmoonstorm {
    function guess(uint256 n) external payable;
}

interface ILollercoaster_0xmoonstorm {
    function randInt(uint256 n) external view returns (uint256);
}

contract Exploit_0xmoonstorm {
    constructor(IChallenge_0xmoonstorm instance) payable {
        // TODO
    }

    function finalize() external {
        // TODO

        selfdestruct(payable(msg.sender));
    }
}

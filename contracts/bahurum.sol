// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_bahurum {
    function guess(uint256 n) external payable;
}

interface ILollercoaster_bahurum {
    function randInt(uint256 n) external view returns (uint256);
}

contract Exploit_bahurum {
    constructor(IChallenge_bahurum instance) payable {
        // TODO
    }

    function finalize() external {
        // TODO

        selfdestruct(payable(msg.sender));
    }
}

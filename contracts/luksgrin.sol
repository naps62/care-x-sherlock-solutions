// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_luksgrin {
    function guess(uint256 n) external payable;
}

interface ILollercoaster_luksgrin {
    function randInt(uint256 n) external view returns (uint256);
}

contract Exploit_luksgrin {
    constructor(IChallenge_luksgrin instance) payable {}

    function finalize() external {
        // reach currentFloor > 5

        selfdestruct(payable(msg.sender));
    }
}

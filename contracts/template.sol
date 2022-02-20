// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_template {
    function guess(uint256 n) external payable;
}

contract Exploit_template {
    IChallenge_template instance;

    constructor(IChallenge_template _instance) payable {
        instance = _instance;
    }

    function finalize() external {
        selfdestruct(payable(msg.sender));
    }
}

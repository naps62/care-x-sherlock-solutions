// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_BowTiedPickle {
    function pick1(string memory) external payable;

    function pick2() external payable;

    function pick3(bytes16) external;

    function open() external;
}

contract Exploit_BowTiedPickle {
    IChallenge_BowTiedPickle instance;

    constructor(IChallenge_BowTiedPickle _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        require(msg.value >= 33, "not enough value");

        string memory PIN = unicode"‮6167209‬";

        instance.pick1(PIN);
        instance.pick2{value: 33}();
        instance.pick3(bytes2(0x6942));
        instance.open();

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

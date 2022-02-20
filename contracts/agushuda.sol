// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_agushuda {}

contract Exploit_agushuda {
    IChallenge_agushuda instance;

    constructor(IChallenge_agushuda _instance) payable {
        instance = _instance;
    }

    function finalize() external {
        selfdestruct(payable(msg.sender));
    }
}

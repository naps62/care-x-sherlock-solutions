// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

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
        bytes4 selector = Exploit_ebaizel.foo.selector;
        int8 arg = 41;
        int16 arg2 = 254;
        int8 extra = -1;
        // console.log("selector length ", abi.encodeWithSelector(selector).length);
        // console.log("selector length ", abi.encodeWithSelector(selector, arg).length);
        // console.log("selector length ", abi.encodeWithSelector(selector, arg2).length);
        // (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(selector, arg2));
        bytes memory call = abi.encodePacked(Exploit_ebaizel.foo.selector, bytes32(0), arg);
        (bool success, bytes memory data) = address(this).call(abi.encodePacked(Exploit_ebaizel.foo.selector, bytes31(bytes32(uint256(0xffff))), arg));
        // console.log(success);
        // console.log(data.length);
        // instance.crackCode(42);

        selfdestruct(payable(address(this)));
    }

    function foo(uint8 arg) external {
        console.log("data length ", msg.data.length);
        console.log("original: ", uint256(arg));
        for (uint256 i = 0; i < msg.data.length; ++i) {
            console.logBytes1(msg.data[i]);
        }
        // bytes memory n = abi.encodePacked(bytes28(0), msg.data);
        // (bytes32 sig, bytes32 data) = abi.decode(abi.encodePacked(bytes28(0), msg.data), (bytes32, bytes32));
        // console.log("full: ", uint256(data));
    }

    receive() external payable {}
}

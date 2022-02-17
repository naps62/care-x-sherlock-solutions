// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "hardhat/console.sol";

// interface IChallenge_lucyoa {}

// contract Exploit_lucyoa {
//     IChallenge_lucyoa instance;
//     Test test;

//     constructor(IChallenge_lucyoa _instance) payable {
//         instance = _instance;
//         test = new Test();
//     }

//     function finalize() external {
//         console.log(test.unlocked());
//         test.lock();
//         console.log(test.unlocked());

//         selfdestruct(payable(msg.sender));
//     }

//     // function receiver() {
//     //     // faucet()
//     // }
// }

// contract Test {
//     struct Foo {
//         uint256 name;
//         address author;
//         uint256 votes;
//     }

//     address[] public tokens;
//     Foo[] public foos;
//     mapping(uint256 => mapping(address => bool)) public votes;
//     address[] public govTokens;
//     bool public unlocked;

//     constructor() {
//         tokens.push(address(0));
//         tokens.push(address(0));
//         tokens.push(address(0));
//     }

//     // uint256 x;
//     // uint256 y;
//     // uint256 z;

//     // Foo[] foos;

//     function lock() external {
//         require(true);

//         Foo storage foo;
//         foo.name = type(uint256).max;
//         foo.author = msg.sender;
//         foo.votes = type(uint256).max;

//         foos.push(foo);
//         console.log(tokens[0]);
//     }
// }

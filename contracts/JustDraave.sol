// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_JustDravee {
    function unSheerLock1(
        string calldata passphrase1,
        string calldata passphrase2,
        string calldata passphrase3,
        string calldata passphrase4,
        string calldata passphrase5,
        bytes8 keyThree
    ) external payable;

    function unSheerLock2(
        string calldata passphrase4,
        string calldata passphrase2,
        string calldata passphrase3,
        string calldata passphrase1,
        string calldata passphrase5,
        bytes8 keyThree
    ) external payable;

    function unSheerLock3(
        string calldata passphrase1,
        string calldata passphrase2,
        string calldata passphrase3,
        string calldata passphrase4,
        string calldata passphrase5,
        bytes8 keyThree
    ) external payable;

    function unSheerLock4(
        string calldata passphrase1,
        string calldata passphrase2,
        string calldata passphrase3,
        string calldata passphrase4,
        string calldata passphrase5,
        bytes8 keyThree
    ) external payable;

    function unSheerLock5(
        string calldata passphrase3,
        string calldata passphrase2,
        string calldata passphrase1,
        string calldata passphrase4,
        string calldata passphrase5,
        bytes8 keyThree
    ) external payable;

    function unSheerLock6(
        string calldata passphrase1,
        string calldata passphrase2,
        string calldata passphrase3,
        string calldata passphrase5,
        bytes8 keyThree
    ) external payable;

    function unSheerLock7(
        string calldata passphrase5,
        string calldata passphrase2,
        string calldata passphrase3,
        string calldata passphrase4,
        string calldata passphrase1,
        bytes8 keyThree
    ) external payable;
}

interface ISetup_JustDraave {
    function attackfunction1(
        string calldata key1,
        string calldata key2,
        string calldata key3,
        string calldata key4,
        string calldata key5,
        bytes8 key6
    ) external payable;

    function attackfunction2(
        string calldata key1,
        string calldata key2,
        string calldata key3,
        string calldata key4,
        string calldata key5,
        bytes8 key6
    ) external payable;

    function attackfunction3(
        string calldata key1,
        string calldata key2,
        string calldata key3,
        string calldata key4,
        string calldata key5,
        bytes8 key6
    ) external payable;

    function attackfunction4(
        string calldata key1,
        string calldata key2,
        string calldata key3,
        string calldata key4,
        string calldata key5,
        bytes8 key6
    ) external payable;

    function attackfunction5(
        string calldata key1,
        string calldata key2,
        string calldata key3,
        string calldata key4,
        string calldata key5,
        bytes8 key6
    ) external payable;

    function attackfunction6(
        string calldata key1,
        string calldata key2,
        string calldata key3,
        string calldata key4,
        string calldata key5,
        bytes8 key6
    ) external payable;

    function attackfunction7(
        string calldata key1,
        string calldata key2,
        string calldata key3,
        string calldata key4,
        string calldata key5,
        bytes8 key6
    ) external payable;
}

contract Exploit_JustDravee {
    IChallenge_JustDravee instance;
    ISetup_JustDraave setup;

    constructor(IChallenge_JustDravee _instance) payable {
        instance = _instance;
        // instance = IChallenge_JustDravee(address(new SheerLocking()));
        setup = ISetup_JustDraave(0x1f5c09a7d6a9B30b43DDDAABD384425DEe0ADe91);

        bytes8 key1 = hex"ffffffff";
        instance.unSheerLock1{value: 24725 wei}("Benedict ", "Cumberbatch", " is ", "the ", "best", key1);
        instance.unSheerLock2("", "", "I waited so long for  season 4 :'( ", "Jim Moriarty is nice too. ", "", key1);
        instance.unSheerLock3("The Woman", " is ", "", "Missy/", "The Master in Doctor Who", key1);
        instance.unSheerLock4("", "", "John Watson had a role in Ali G (Ricky C) ", "", "", key1);
        instance.unSheerLock5("Henry Cavill:", "", " Sherlock of Steel ", "and Enola's big bro", "", key1);
        instance.unSheerLock6("Sir Arthur Conan Doyle died in 1930, so copyright on Sherlock Holmes expired in 2000 in ", "the ", "", "UK", key1);
        instance.unSheerLock7("Jonny ", "Lee ", "", "Miller ", "and Lucy Liu were a good team too!", key1);
    }

    function finalize() external payable {
        selfdestruct(payable(msg.sender));
    }

    fallback() external payable {}

    receive() external payable {}
}

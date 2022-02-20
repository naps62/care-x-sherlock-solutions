// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_saianmk {
    function leverPos() external view returns (uint8);

    function cam3Val() external view returns (uint8);

    function cam2Val() external view returns (uint8);

    function cam1Val() external view returns (uint8);

    function cam3Tab() external view returns (uint8);

    function cam2Tab() external view returns (uint8);

    function cam1Tab() external view returns (uint8);

    function pins() external view returns (uint8);

    function dial(uint8, bool) external;

    function unlock(uint8) external;
}

// leverPos = 0b100000 (32)
// cam1Tab=2
// cam2Tab=8
// cam3Tab=2

// pins = 0b10110100 (180)

contract Exploit_saianmk {
    IChallenge_saianmk instance;

    constructor(IChallenge_saianmk _instance) payable {
        instance = _instance;
        instance = IChallenge_saianmk(address(new Combination(32, 2, 8, 2, 180)));
    }

    function finalize() external {
        // instance.unlock(1);
        uint8 key = 180 ^ 0xff;
        // part1Unlocked();
        // part2Unlocked(key);
        instance.dial(0x06, false);
        instance.dial(0x04, false);
        // instance.unlock(key);
        selfdestruct(payable(msg.sender));
    }

    function part1Unlocked() internal view {
        uint8 leverPos = instance.leverPos();
        uint8 cam1 = instance.cam1Val();
        uint8 cam2 = instance.cam2Val();
        uint8 cam3 = instance.cam3Val();

        console.log("leverPos %s %d", toBinary(leverPos), leverPos);
        console.log("cam1Val  %s %d", toBinary(cam1), cam2);
        console.log("cam2Val  %s %d", toBinary(cam2), cam2);
        console.log("cam3Val  %s %d", toBinary(cam3), cam3);

        console.log((cam1 & cam2 & cam3) == instance.leverPos());
    }

    function part2Unlocked(uint8 _key) internal view {
        console.log(instance.pins() ^ _key == type(uint8).max);
    }

    function toBinary(uint8 n) internal pure returns (string memory) {
        // revert on out of range input
        // require(n < 32);

        bytes memory output = new bytes(8);

        for (uint8 i = 0; i < 8; i++) {
            output[7 - i] = (n % 2 == 1) ? bytes1("1") : bytes1("0");
            n /= 2;
        }

        return string(output);
    }
}

contract Combination {
    bool public unlocked;

    uint8 public leverPos;

    uint8 public cam3Val;
    uint8 public cam2Val;
    uint8 public cam1Val;

    uint8 public cam3Tab;
    uint8 public cam2Tab;
    uint8 public cam1Tab;

    uint8 public pins;

    mapping(uint8 => uint8) log2;

    /**
     * @param _leverPos Target position of the slots
     * @param _val1 Initial position of tab1
     * @param _val2 Initial position of tab2
     * @param _val3 Initial position of tab3
     * @param _pins Pin value of the key lock
     */
    constructor(
        uint8 _leverPos,
        uint8 _val1,
        uint8 _val2,
        uint8 _val3,
        uint8 _pins
    ) {
        leverPos = _leverPos;
        cam1Tab = _val1;
        cam2Tab = _val2;
        cam3Tab = _val3;

        pins = _pins;

        setCamValues();

        log2[128] = 7;
        log2[64] = 6;
        log2[32] = 5;
        log2[16] = 4;
        log2[8] = 3;
        log2[4] = 2;
        log2[2] = 1;
        log2[1] = 0;
    }

    /**
     * @dev Set notch values from tab position
     */
    function setCamValues() internal {
        cam1Val = rotateLeft(cam1Tab, 5);
        cam2Val = rotateLeft(cam2Tab, 3);
        cam3Val = rotateLeft(cam3Tab, 5);
        console.log("\nsetCamValues");
        console.log("cam1Val  %s %d", toBinary(cam1Val), cam2Val);
        console.log("cam2Val  %s %d", toBinary(cam2Val), cam2Val);
        console.log("cam3Val  %s %d", toBinary(cam3Val), cam3Val);
    }

    function toBinary(uint8 n) internal pure returns (string memory) {
        // revert on out of range input
        // require(n < 32);

        bytes memory output = new bytes(8);

        for (uint8 i = 0; i < 8; i++) {
            output[7 - i] = (n % 2 == 1) ? bytes1("1") : bytes1("0");
            n /= 2;
        }

        return string(output);
    }

    /**
     * @dev Function to perform left rotation
     */
    function rotateLeft(uint8 _val, uint8 _count) public pure returns (uint8) {
        return (_val >> (8 - _count)) | (_val << _count);
    }

    /**
     * @dev Function to perform right rotation
     */
    function rotateRight(uint8 _val, uint8 _count) public pure returns (uint8) {
        return (_val << (8 - _count)) | (_val >> _count);
    }

    function cam3(uint8 _rotateVal, bool _direction) public {
        if (_direction) {
            cam3Tab = rotateRight(cam3Tab, _rotateVal);
        } else {
            cam3Tab = rotateLeft(cam3Tab, _rotateVal);
        }
    }

    function cam2(uint8 _rotateVal, bool _direction) public {
        uint8 gap = 0;
        uint8 _cam2Tab = cam2Tab;
        uint8 _cam3Tab = cam3Tab;

        if (_direction) {
            gap = _cam2Tab > _cam3Tab ? log2[_cam2Tab] - log2[_cam3Tab] - 1 : 8 - log2[_cam3Tab] + log2[_cam2Tab] - 1;

            cam2Tab = rotateRight(_cam2Tab, _rotateVal);
        } else {
            gap = _cam2Tab > _cam3Tab ? (8 - log2[_cam2Tab] + log2[_cam3Tab]) - 1 : (log2[_cam3Tab] - log2[_cam2Tab]) - 1;

            cam2Tab = rotateLeft(_cam2Tab, _rotateVal);
        }

        if (gap < _rotateVal) {
            cam3(_rotateVal - gap, _direction);
        }
    }

    function cam1(uint8 _rotateVal, bool _direction) internal {
        uint8 gap = 0;
        uint8 _cam1Tab = cam1Tab;
        uint8 _cam2Tab = cam2Tab;

        if (_direction) {
            gap = _cam1Tab > _cam2Tab ? log2[_cam1Tab] - log2[_cam2Tab] - 1 : 8 - log2[_cam2Tab] + log2[_cam1Tab] - 1;

            cam1Tab = rotateRight(_cam1Tab, _rotateVal);
        } else {
            gap = _cam1Tab > _cam2Tab ? 8 - log2[_cam1Tab] + log2[_cam2Tab] - 1 : log2[_cam2Tab] - log2[_cam1Tab] - 1;

            cam1Tab = rotateLeft(_cam1Tab, _rotateVal);
        }

        if (gap < _rotateVal) {
            cam2(_rotateVal - gap, _direction);
        }
    }

    /**
     * @dev Main function
     * @param _rotateVal - Number of rotation to perform
     * @param _direction - Direction of rotation ( right => true, left => false)
     */
    function dial(uint8 _rotateVal, bool _direction) public {
        require(_rotateVal > 0 && _rotateVal < 8, "Rotate values out of bounds");

        cam1(_rotateVal, _direction);

        setCamValues();
    }

    /**
     * @dev Function to unlock and lock, enter key to unlock
     * @param _key Key value
     */
    function unlock(uint8 _key) public {
        unlocked = ((cam1Val & cam2Val & cam3Val) == leverPos);
        console.log("unlocked? ", unlocked);

        // Simple reset
        dial(7, false);
        dial(7, true);
        dial(3, false);
    }
}

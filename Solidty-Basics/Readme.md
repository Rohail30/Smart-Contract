# Solidity Basics

## 1. What is Solidity?
Solidity is a high-level, statically-typed programming language designed for writing smart contracts on the Ethereum blockchain.

### Example:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {
    string public message = "Hello, Blockchain!";
}
```

## 2. Variables
Variables store data in a smart contract.

### Example:
```solidity
contract Variables {
    uint public number = 100; // State variable

    function getNumber() public view returns (uint) {
        return number; // Accessing a state variable
    }
}
```

## 3. Types
Solidity has various data types: uint, int, bool, string, address, bytes, etc.

### Example:
```solidity
contract Types {
    uint public unsignedInteger = 10;
    int public signedInteger = -10;
    bool public isTrue = true;
    string public text = "Solidity";
    address public wallet = msg.sender;
}
```

## 4. Functions
Functions define the logic of a contract.

### Example:
```solidity
contract Functions {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }
}
```

## 5. Visibility
Defines who can access a function or variable.

### Example:
```solidity
contract Visibility {
    uint private x = 10; // Only accessible inside this contract
    uint internal y = 20; // Accessible in derived contracts
    uint public z = 30; // Accessible by anyone
}
```

## 6. Modifiers
Used to change the behavior of functions.

### Example:
```solidity
contract Modifiers {
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}
```

## 7. Custom Modifiers
Used to restrict access or add checks before executing a function.

### Example:
```solidity
contract CustomModifiers {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}
```

## 8. Constructors
Special function that runs once when deploying a contract.

### Example:
```solidity
contract Constructor {
    string public message;

    constructor(string memory _message) {
        message = _message;
    }
}
```

## 9. Global Variables
Provides blockchain-related information.

### Example:
```solidity
contract GlobalVars {
    address public sender = msg.sender;
    uint public time = block.timestamp;
    uint public blockNum = block.number;
}
```

## 10. Operators
Solidity supports arithmetic, comparison, and logical operators.

### Example:
```solidity
contract Operators {
    uint public sum = 5 + 3;
    bool public isEqual = (5 == 5);
}
```

## 11. Conditionals
Allows decision-making logic.

### Example:
```solidity
contract Conditionals {
    function checkEven(uint _num) public pure returns (bool) {
        return _num % 2 == 0;
    }
}
```

## 12. Arrays
Solidity supports static and dynamic arrays.

### Example:
```solidity
contract Arrays {
    uint[] public numbers;
    function addNumber(uint _num) public {
        numbers.push(_num);
    }
}
```

## 13. Mappings
Key-value storage.

### Example:
```solidity
contract Mappings {
    mapping(address => uint) public balances;
}
```

## 14. Structs
Custom data structures.

### Example:
```solidity
contract Structs {
    struct Person {
        string name;
        uint age;
    }
    Person public person = Person("Alice", 30);
}
```

## 15. Events
Allow logging events on the blockchain.

### Example:
```solidity
contract Events {
    event MessageSent(address indexed sender, string message);

    function sendMessage(string memory _message) public {
        emit MessageSent(msg.sender, _message);
    }
}
```

## 16. Ether
Handles payments and transfers.

### Example:
```solidity
contract EtherHandling {
    function sendEther(address payable _receiver) public payable {
        _receiver.transfer(msg.value);
    }
}
```

## 17. Errors
Handling errors using `require`, `assert`, and `revert`.

### Example:
```solidity
contract Errors {
    function check(uint _num) public pure {
        require(_num > 0, "Number must be greater than zero");
    }
}
```

## 18. Inheritance
Contracts can inherit from other contracts.

### Example:
```solidity
contract Parent {
    uint public value = 100;
}

contract Child is Parent {
    function getValue() public view returns (uint) {
        return value;
    }
}
```

## 19. Calling Other Contracts
Allows interaction between contracts.

### Example:
```solidity
contract A {
    function getValue() public pure returns (uint) {
        return 42;
    }
}

contract B {
    function callA(address _contractA) public view returns (uint) {
        A a = A(_contractA);
        return a.getValue();
    }
}
```

## 20. Interfaces
Defines contract functions without implementation.

### Example:
```solidity
interface IExample {
    function getValue() external view returns (uint);
}

contract Example is IExample {
    function getValue() public pure override returns (uint) {
        return 100;
    }
}

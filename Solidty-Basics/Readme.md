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
---

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
---

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
---

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

In Solidity, functions can be categorized into **write functions** (which modify the blockchain state) and **read functions** (which only retrieve data without modifying the state).

### **I. Write Function (State-Changing Function)**
A **write function** modifies the contract’s state and requires gas when executed.

### **Example of a Write Function**
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WriteExample {
    uint public number;

    // This function modifies the blockchain state
    function setNumber(uint _number) public {
        number = _number; // Modifies the state variable
    }
}
```
### **Key Points:**
✅ Modifies the blockchain state.  
✅ Costs **gas** when executed.  
✅ Must be executed in a **transaction** (not a free call).  


### **II. Read Function (State-Reading Function)**
A **read function** does not modify the blockchain state; it only retrieves existing data.

### **Example of a Read Function**
```solidity
contract ReadExample {
    uint public number = 10;

    // This function only reads the state and does not modify it
    function getNumber() public view returns (uint) {
        return number;
    }
}
```
### **Key Points:**
✅ Does **not** modify the blockchain state.  
✅ **Free to call** (no gas fee when called externally).  
✅ Marked with the `view` or `pure` keyword.  

## **Comparison Table**
| Function Type  | Modifies State? | Costs Gas? | Example |
|--------------|--------------|------------|---------|
| **Write Function** (`setNumber`) | ✅ Yes | ✅ Yes | `setNumber(5);` |
| **Read Function** (`getNumber`) | ❌ No | ❌ No (if called externally) | `getNumber();` |

---

## 5. Visibility
Defines who can access a function or variable.

### Example:
```solidity
contract Visibility {
    uint private x = 10; // Only accessible inside this contract
    uint internal y = 20; // Accessible in derived contracts can be inherited
    uint public z = 30; // Accessible by anyone
}
```
In Solidity, functions can be categorized based on their **visibility, behavior, and purpose**. Here are the different types of functions:

### Functions:
### *I. Based on Visibility**
Visibility determines who can call the function.

### **a) Public Functions (`public`)**
- Can be called **externally (outside the contract)** and **internally (within the contract and derived contracts)**.
- Automatically creates a function selector that can be accessed externally.

#### Example:
```solidity
contract Example {
    function publicFunction() public pure returns (string memory) {
        return "This is a public function";
    }
}
```


### **b) Private Functions (`private`)**
- Can **only** be accessed **within the contract** where they are defined.
- Not accessible by derived contracts.

#### Example:
```solidity
contract Example {
    function privateFunction() private pure returns (string memory) {
        return "This is a private function";
    }
}
```


### **c) Internal Functions (`internal`)**
- Can be accessed **within the contract** and **by derived contracts**.
- Cannot be called externally.

#### Example:
```solidity
contract Parent {
    function internalFunction() internal pure returns (string memory) {
        return "This is an internal function";
    }
}

contract Child is Parent {
    function callInternalFunction() public pure returns (string memory) {
        return internalFunction(); // Allowed
    }
}
```

### **d) External Functions (`external`)**
- Can be called **only from outside** the contract.
- Cannot be called from within the contract unless using `this.functionName()`.
  
#### Example:
```solidity
contract Example {
    function externalFunction() external pure returns (string memory) {
        return "This is an external function";
    }
}
```

## **II. Based on Behavior**
These define how the function interacts with storage and transactions.

### **a) View Functions (`view`)**
- Read data from the blockchain but **do not modify the state**.
- Does **not** cost gas when called externally.

#### Example:
```solidity
contract Example {
    uint public number = 42;

    function getNumber() public view returns (uint) {
        return number; // Reading state, not modifying it
    }
}
```

### **b) Pure Functions (`pure`)**
- Neither **read nor modify** blockchain state.
- Used for **computations**.

#### Example:
```solidity
contract Example {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b; // No state modification
    }
}
```


### **c) Payable Functions (`payable`)**
- Allows the contract to receive **Ether**.
- Needed for functions handling cryptocurrency transactions.

#### Example:
```solidity
contract Example {
    function deposit() public payable {
        // Function can receive Ether
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
```
### **d) Fallback and Receive Functions**
- Special functions used for handling direct Ether transfers.

#### **Fallback (`fallback`)**
- Triggered when **no function matches the call**.
- Must be `external`.

#### **Receive (`receive`)**
- Triggered when **Ether is sent without data**.

```solidity
contract Example {
    event Received(address sender, uint amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable {
        emit Received(msg.sender, msg.value);
    }
}
```

## **III. Based on Modifiers**
Modifiers are used to change function behavior.

### **a) Functions with Custom Modifiers**
Used to **restrict access** or apply conditions.

#### Example:
```solidity
contract Example {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function restrictedFunction() public onlyOwner {
        // Only the owner can call this
    }
}
```

### **Summary Table**
| Function Type  | Description |
|---------------|-------------|
| **public** | Accessible by everyone |
| **private** | Accessible only inside the contract |
| **internal** | Accessible inside the contract and derived contracts |
| **external** | Can only be called from outside the contract |
| **view** | Reads blockchain state but does not modify it |
| **pure** | Does not read or modify the blockchain state |
| **payable** | Allows receiving Ether |
| **fallback** | Handles unmatched function calls |
| **receive** | Handles plain Ether transfers |

---

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

## Visibility
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

### **1. Based on Visibility**
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

### **2. Based on Behavior**
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

### **3. Based on Modifiers**
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

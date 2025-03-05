## Functions
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

### **1. Write Function (State-Changing Function)**
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


### **2. Read Function (State-Reading Function)**
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

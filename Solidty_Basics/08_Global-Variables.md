## Global Variables
Provides blockchain-related information.

### Example:
```solidity
contract GlobalVars {

    constructor() {
contractAddress = address(this); // "this" is a Global variable

}

    address public sender = msg.sender;
    uint public time = block.timestamp;
    uint public blockNum = block.number;
}
```

### **Explanation of Global Variables Used**
| **Variable**       | **Description** |
|------------------|----------------|
| `msg.sender`    | The address of the sender who called the function or deployed the contract. |
| `block.timestamp` | The Unix timestamp of when the block was mined. Useful for time-based logic. |
| `block.number`   | The current block number in the blockchain. |
| `address(this)`  | The address of the deployed contract itself. |

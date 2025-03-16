## Custom Modifiers
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

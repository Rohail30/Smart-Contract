## Modifiers
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

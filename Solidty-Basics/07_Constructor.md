## Constructors
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

## Types
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

## Variables
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

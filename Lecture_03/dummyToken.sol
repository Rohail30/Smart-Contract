// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract dummyToken {
    
    uint256 maxSupply = 200000;  
    uint256 ciculatingSupply = 0;
    address owner = msg.sender;
    
    mapping(address => uint256) public balanceOf;

    function deposit(uint256 amount) public {
        balanceOf[msg.sender] += amount;
    }

    function transfer(address sender, address recipient, uint256 amount) public returns (bool) {

        require(balanceOf[sender] >= amount, "Not Enough Balance");
        require(recipient != address(0), "Zero Address Detected");

        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;

        return true;
    }

    function mintToken(uint256 amount) public returns (bool) {
        
        require(msg.sender == owner, "Not Authorized to Mint Tokens");
        require(amount > 0, "Amount Should be greater than Zero");
        require(ciculatingSupply + amount <= maxSupply, "Maxmimum Supply Reached");

        balanceOf[msg.sender] += amount;
        ciculatingSupply += amount;
    
        return true;
    }
}
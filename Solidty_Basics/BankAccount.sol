
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract BankAccount {
    address public owner;

    modifier onlyOwner() {
        require(owner == msg.sender, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
    }

    function checkContractBalance() external view returns (uint) {
        return address(this).balance;
    }

    function checkOwnerBalance() external view returns (uint) {
        return owner.balance;
    }

    function checkAccountBalance(address _account) external view returns (uint) {
        return _account.balance;
    }

    function transfer(address _addr, uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient contract balance");
        payable(_addr).transfer(_amount);
    }

    function withdraw(uint256 _amount) external payable onlyOwner {
        require(_amount <= address(this).balance, "Insufficient Balance");
        payable(msg.sender).transfer(_amount);
    }

    function transferWithFee(address _addr, uint256 _amount) external onlyOwner {
        require(_amount <= address(this).balance, "Insufficient balance");
        address recepient = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        uint tax = (_amount * 10 / 100);
        _amount = _amount - tax;
        payable(_addr).transfer(_amount);
        payable(recepient).transfer(tax);
    }
    
}


// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(address recipient) ERC20("MyToken", "MTK") {
        _mint(recipient, 10000000 * 10 ** decimals());
    }
}

contract Staking {
    MyToken public token;
    address public owner;
    uint256 claimTime;
    mapping(address => uint256) public stakedAmount;
    mapping(address => uint256) public stakedTimestamp;

    constructor(address _token){
        token = MyToken(_token);
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        stakedTimestamp[msg.sender] = block.timestamp;
        stakedAmount[msg.sender] += _amount ;
        token.transfer(address(this),_amount);
    }

    function unstake(uint _amount) public {
        require(block.timestamp >= stakedTimestamp[msg.sender] + 10, "Not eligible for withdrawal");
        stakedAmount[msg.sender] -= _amount; 
        claimTime = block.timestamp - stakedTimestamp[msg.sender] / 1 days;
         uint256 reward = (stakedAmount[msg.sender]/100)*claimTime;
        token.transferFrom( address(this),msg.sender, _amount);
        token.transferFrom(address(this), msg.sender, reward);
        

    }

    function checkAccountBalance(address _account) external view returns (uint) {
        return _account.balance;
    }

    function calculateReward(address _staker) public view returns (uint256) {
        
    }


    function checkContractBalance() external view returns (uint) {
        return address(this).balance;
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
    }


}

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
    mapping(address => uint256) public stakedAmount;

    function stake(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        token.transfer(address(this),_amount);
        stakedAmount[msg.sender] += _amount;
    }

    function unstake(uint _amount) public {
        require(stakedAmount[msg.sender] >= _amount, "Insufficient Balance");
        stakedAmount[msg.sender] -= _amount;
        token.transfer( msg.sender, _amount);
    }

     function withdraw(uint256 _amount) external {
        token.transfer(msg.sender, _amount);
        stakedAmount[msg.sender] -= _amount;
    }

}

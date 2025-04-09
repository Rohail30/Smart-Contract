// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(address recipient) ERC20("MyToken", "MTK") {
        _mint(recipient, 1000000 * 10**decimals());
    }
}

contract Staking {

    MyToken public token;
    mapping(address => uint256) public stakedAmount;
    mapping(address => uint256) public stakedTime;

    constructor(address _token) {
        token = MyToken(_token);
    }

    function stake(uint256 _amount) public {
        stakedAmount[msg.sender] += _amount;
        stakedTime[msg.sender] = block.timestamp;
        token.transferFrom(msg.sender, address(this), _amount);
    }

    function unstake(uint256 _amount) public {
        require(block.timestamp >= stakedTime[msg.sender] + 1 days, "You can only unstake after 1 day");

        uint256 timeDiff = (block.timestamp - stakedTime[msg.sender]) / 1 days;

        uint256 reward = (timeDiff * stakedAmount[msg.sender]) / 100;

        stakedAmount[msg.sender] -= _amount;
        stakedTime[msg.sender] = block.timestamp;

        token.transfer(msg.sender, _amount + reward);
    }
}

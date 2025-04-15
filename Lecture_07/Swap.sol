// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor(address recipient) ERC20("TokenA", "TKA") {
        _mint(recipient, 1000000 * 1 ** decimals());
    }
}

contract TokenB is ERC20 {
    constructor(address recipient) ERC20("TokenB", "TKB") {
        _mint(recipient, 1000000 * 1 ** decimals());
    }
}

contract Swapping {
    IERC20 tokenA;
    IERC20 tokenB;
    uint256 rate;
    address owner;

    event Swap(address _tA, address _tB, uint256 _r);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function setRate(uint256 _rate) external onlyOwner {
        rate = _rate;
    }

    constructor(
        address _tokenA,
        address _tokenB,
        uint256 _rate
    ) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        rate = _rate;
        owner = msg.sender;
    }

    function swap(uint256 _amount) external {
        require(_amount > 0, "Amount should be greater than ZERO");

        tokenA.transferFrom(msg.sender, address(this), rate * _amount);
        tokenB.transfer(msg.sender, _amount);

        emit Swap(address(tokenA), address(tokenB), rate);
    }
}

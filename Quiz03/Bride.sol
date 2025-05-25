// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract TokenA is ERC20 {
    constructor(address recipient) ERC20("TokenA", "TKA") {
        _mint(recipient, 1_000_000 * 10 ** decimals());
    }
}

contract TokenB is ERC20, ERC20Burnable {
    address public bridge;

    constructor() ERC20("TokenB", "TKB") {}

    function setBridge(address _bridge) external {
        require(bridge == address(0), "Bridge already set");
        bridge = _bridge;
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

contract Bridge {
    IERC20 public immutable tokenA;
    TokenB public immutable tokenB;

    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = TokenB(_tokenB);
    }

    event BridgedAToB(address user, uint256 amount);
    event BridgedBToA(address user, uint256 amount);

    function bridgeAToB(uint256 amount) external {
        require(tokenA.transferFrom(msg.sender, address(this), amount), "TokenA transfer failed");
        tokenB.mint(msg.sender, amount);
        emit BridgedAToB(msg.sender, amount);
    }

    function bridgeBToA(uint256 amount) external {
        tokenB.burnFrom(msg.sender, amount);
        require(tokenA.transfer(msg.sender, amount), "TokenA transfer failed");
        emit BridgedBToA(msg.sender, amount);
    }
}

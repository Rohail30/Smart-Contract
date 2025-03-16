// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MustanAli is ERC20 {

    constructor(address recipient) ERC20("MustanAli", "MA") {
        _mint(recipient, 100000 * 10**decimals());
    }

    // address public feeAddress = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    //  event success( address a, uint256 amount);

//     function transfer(address to, uint256 value) public virtual override returns (bool) {
//     address sender = _msgSender();
    
//     uint256 fee = (value * 10) / 100;
//     value -= fee;

//     _transfer(sender, feeAddress, fee);
//     _transfer(sender, to, value);
    
//     emit success(to, amount);

//     return true;
// }

}

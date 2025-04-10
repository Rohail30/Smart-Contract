
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(address recipient) ERC20("MyToken", "MTK") {
        _mint(recipient, 1000000 * 10**decimals());
    }
}

contract Auction {
    MyToken token;
    struct Listing{
        address seller;
        ERC20 token;
        uint pricePerToken;
        uint remainingAmount;
    }

    Listing[] public listings;
    uint256 public ListingId;

     constructor(address _token){
        token = MyToken(_token);
    }

    function listTokens(MyToken _token, uint256 totalAmount, uint256 pricePerToken) external {
        require(totalAmount > 0, "Amount must be > 0");
        require(pricePerToken > 0, "Price must be > 0");
        _token.transferFrom(msg.sender, address(this), totalAmount);
    }

     function buyTokens(uint256 listingId, uint256 tokenAmount) external payable {
        Listing storage listing = listings[listingId];

        require(tokenAmount > 0 && tokenAmount <= listing.remainingAmount, "Invalid buy amount");

        uint256 totalCost = tokenAmount * listing.pricePerToken;
        require(msg.value >= totalCost, "Insufficient ETH sent");

        require(listing.token.transfer(msg.sender, tokenAmount), "Token transfer failed");

        payable(listing.seller).transfer(totalCost);

        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost);
        }
        listing.remainingAmount -= tokenAmount;
    }

    function getListCount() public view returns(uint256){
        return listings.length;
    }

}

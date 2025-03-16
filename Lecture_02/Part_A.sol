// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Part_A {

    receive() external payable {}   // Function to receive Ether
    address payable _owner = payable(msg.sender);    //Assinging _owner as the contract deployer
    uint256 public contractBalance = address(this).balance;  //Storing the contract balance before receiving ether

    function sendEther() public payable {
        require(msg.value >= 1 ether,"Minimum 1 ether required");
        contractBalance = address(this).balance;    //Updating the contract balance after receiving ether
        payable(_owner).transfer(contractBalance);  //Transfer the contract balance to the _owner
    }
}
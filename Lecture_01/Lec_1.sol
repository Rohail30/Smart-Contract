// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Lec_1 {
    int a = 10;
    int b = 5;

    function Addition() public view returns (int) {
        return a + b;
    }

    function Division() public view returns (int) {
        require(b != 0, "Cannot divide by zero");
        return a / b;
    }

    function Increment() public returns (int) {
        return ++a;
    }

    bool public flag = true;

    function toggleFlag() public returns (bool) {
        flag = !flag;
        return flag;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function checkEvenOdd(int x) public pure returns (string memory) {
        // if (x % 2 == 0) {
        //     return "Even";
        // } else {
        //     return "Odd";
        // }

        return x % 2 == 0 ? "Number is Even" : "Number is Odd";
    }

    function concatStrings(string memory x, string memory y) public pure returns (string memory) {
        return string(abi.encodePacked(x, y));
    }

    address public _owner;

    constructor() {
        _owner = msg.sender;
    }

    function getOwner() public view returns (address) {
        return _owner;
    }
}

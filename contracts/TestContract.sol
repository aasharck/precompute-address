// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @notice This is the test contract for which the address needs to be precomputed.
contract TestContract {
    address public owner;
    uint public foo;

    /// @notice Just two simple parameters which doesn't actually do anything
    constructor(address _owner, uint _foo) {
        owner = _owner;
        foo = _foo;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./TestContract.sol";

/// @notice this is the contract which helps you precompute the contract address of test contract
contract Factory {

    /// @notice - Compute the address of the contract to be deployed.
    /// @param _owner can be any address
    /// @param _foo is just a random number that is stored in the testContract
    /// @param _salt is a random number used to create an address
    function getAddress(address _owner, uint _foo, uint _salt)
        public
        view
        returns (address)
    {
        
        //getting the bytecode of the contract
        bytes memory bytecode = type(TestContract).creationCode;

        //Appending the bytecode with the arguments
        bytes memory appendedBytecode = abi.encodePacked(bytecode, abi.encode(_owner, _foo));

        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(appendedBytecode))
        );
        //returning the last 20 bytes which will be the address
        return address(uint160(uint(hash)));
    }


    /// @notice this function needs to be called to create a new instance of TestContract. 
    // Once Called it will have the same contract address as the once when getAddress function was called
    /// @param _owner Should be the same as given in getAddress
    /// @param _foo Should be the same as given in getAddress
    /// @param _salt Should be the same as given in getAddress
    function deploy(
        address _owner,
        uint _foo,
        uint _salt
    ) public returns (address) {
        return address(new TestContract{salt: bytes32(_salt)}(_owner, _foo));
    }

}


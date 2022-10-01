// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./TestContract.sol";

contract Factory {

    // Compute the address of the contract to be deployed
    //_salt is a random number used to create an address
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


    function deploy(
        address _owner,
        uint _foo,
        uint _salt
    ) public returns (address) {
        return address(new TestContract{salt: bytes32(_salt)}(_owner, _foo));
    }

}


// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract MerkleTree {
    bytes32[] public hashes;

    constructor () {
        string[4] memory transactions = [
            "account1 -> account2",
            "account2 -> account3",
            "account4 -> account1",
            "account3 -> account4"
        ];
    
        for(uint i = 0; i< transactions.length; i++){
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        uint n = transactions.length;
        uint offset = 0;

        while(n > 0) {
            for(uint i = 0; i < n - 1; i += 2) {
                hashes.push(
                    keccak256(
                        abi.encodePacked(hashes[offset + i], hashes[offset + i + 1])
                    )
                );
            
            offset +=n;
            n = n / 2;
            }
        }
    }

    function getRoot() public view returns(bytes32) {
        return hashes[hashes.length - 1];
    }

}
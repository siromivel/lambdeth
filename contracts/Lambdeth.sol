pragma solidity ^0.5.0;


contract Lambdeth {
    function map(address calluh, uint256[] memory arr, bytes4 cb) public returns (uint[] memory) {
        uint length = arr.length;
        uint256[] memory coll = new uint256[](arr.length);

        for (uint i = 0; i < length; i++) {
            // coll[i] = caller.call(callbackId, arr[i]);
            // coll[i] = caller.call(keccak256("cb(uint)"));
            // uint transformed = caller.call(cb, arr[i]);

            uint256 iteratee = arr[i];

            assembly {
                let free_mem := mload(0x40)
                mstore(free_mem, cb)
                mstore(add(free_mem, 0x04), iteratee)

                let result := call(
                    5000,
                    calluh,
                    0,
                    free_mem,
                    0x20,
                    free_mem,
                    0x20
                )

                let transformed := mload(result)
                mstore(0x40, add(free_mem, 0x20))
            }

        }

        return coll;
    }
}

// (dc.call(bytes4(keccak256("setA(uint256)")),_val))

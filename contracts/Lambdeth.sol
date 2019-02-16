pragma solidity ^0.5.0;


library Lambdeth {

    function map(address sender, uint256[] memory arr, bytes4 cb) public returns (uint[] memory) {

        uint length = arr.length;
        uint upper  = (length + 31) / 32;

        assembly {
            let return_array := mload(0x40)
            mstore(return_array, 0x20)
            mstore(add(return_array, 32), length)

            let lambda := mload(0x40)
            mstore(lambda, cb)

            for { let i := 0 } lt(i, upper) { i := add(i, 1) } {
                mstore(add(lambda, 0x04), mload(add(return_array, mul(32, add(1, i)))))

                let result := call(
                    5000,
                    sender,
                    0,
                    return_array,
                    0x20,
                    return_array,
                    0x20
                )

                let transformed := mload(result)

                mstore(0x40, add(transformed, add(0x20, mul(i, 0x20))))
            }
        }
    }
}

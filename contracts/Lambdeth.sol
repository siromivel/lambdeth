pragma solidity ^0.5.0;


contract Lambdeth {

    function map(address caller, uint[] memory arr, bytes4 cb) public view returns (uint[] memory) {
        uint length = arr.length;
        uint[] memory returnArray = new uint[](length);

        for (uint i = 0; i < length; i++) {
            (bool success, bytes memory data) = caller.staticcall(abi.encodeWithSelector(cb, arr[i]));

            require(success);
            returnArray[i] = sliceUint(data, 0x00);
        }

        return returnArray;
    }

    function sliceUint(bytes memory bs, uint start) internal pure returns (uint) {
        require(bs.length >= start + 32, "slicing out of range");
        uint x;
        assembly {
            x := mload(add(bs, add(0x20, start)))
        }
        return x;
    }
}

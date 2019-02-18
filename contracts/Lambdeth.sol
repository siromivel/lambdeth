pragma solidity ^0.5.0;

/**
 * @title Lambdeth
 * @dev Helpful methods for working with arrays
 */
contract Lambdeth {
    /**
     * @dev Iterates an array and returns a new array with values for which the predicate returns false
     */
    function filter(address caller, uint[] memory arr, bytes4 cb) public view returns (uint[] memory) {
        uint length = arr.length;
        uint filterCount = 0;
        uint[] memory filterArray = new uint[](length);

        for (uint i = 0; i < length; i++) {
            (bool success, bytes memory data) = caller.staticcall(abi.encodeWithSelector(cb, arr[i]));

            require(success);
            bool keep = bytesToBool(data);

            if (keep) {
                filterArray[i - filterCount] = arr[i];
            } else {
                filterCount++;
            }
        }

        length = length - filterCount;
        uint[] memory returnArray = new uint[](length);

        for (uint j = 0; j < length; j++) {
            returnArray[j] = filterArray[j];
        }

        return returnArray;
    }

    /**
     * @dev Iterates an array and returns a new array of equal lenth containing transformed elements
     */
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

    // Converts bytes into uint
    function sliceUint(bytes memory data, uint start) internal pure returns (uint) {
        require(data.length >= start + 32, "slicing out of range");
        uint val;
        assembly {
            val := mload(add(data, add(0x20, start)))
        }
        return val;
    }

    // Converts bytes into bool
    function bytesToBool(bytes memory data) internal pure returns(bool) {
        uint val = sliceUint(data, 0x00);
        return val == 1 ? true : false;
    }
}

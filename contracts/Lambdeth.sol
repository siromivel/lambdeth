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
        uint offset = 0;
        uint[] memory filterArray = new uint[](length);

        for (uint i = 0; i < length; i++) {
            (bool success, bytes memory data) = caller.staticcall(abi.encodeWithSelector(cb, arr[i]));

            require(success);
            bool keep = bytesToBool(data);

            if (keep) {
                filterArray[i - offset] = arr[i];
            } else {
                offset++;
            }
        }

        return trim(length - offset, filterArray);
    }

    /**
     * @dev Iterates an array and returns true if the specified value is present in the array
     */
    function find(uint[] memory arr, uint value) public pure returns (bool) {
        uint length = arr.length;

        for (uint i = 0; i < length; i++) {
            if (arr[i] == value) return true;
        }
        return false;
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

    /**
     * @dev Returns an array containing no more than 1 entry for any value
     */
    function unique(uint[] memory arr) public view returns (uint[] memory) {
        uint length = arr.length;
        uint offset = 0;
        uint[] memory returnArray = new uint[](length);

        for (uint i = 0; i < length; i++) {
            uint value = arr[i];

            if (!this.find(returnArray, value)) {
                returnArray[i - offset] = value;
            } else {
                offset++;
            }
        }

        return trim(length - offset, returnArray);
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

    // Returns a trimmed array
    function trim(uint length, uint[] memory arr) internal pure returns(uint[] memory) {
        uint[] memory returnArray = new uint[](length);

        for (uint i = 0; i < length; i++) {
            returnArray[i] = arr[i];
        }

        return returnArray;
    }
}

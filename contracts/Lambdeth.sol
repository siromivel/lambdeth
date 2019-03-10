pragma solidity ^0.5.0;

/**
 * @title Lambdeth
 * @dev Helpful methods for working with arrays
 */
contract Lambdeth {

    /**
     * @dev Iterates an array and returns true if the specified value is present in the array
     */
    function concat(uint[] memory arr1, uint[] memory arr2) public pure returns (uint[] memory) {
        uint length1 = arr1.length;
        uint length2 = arr2.length;
        uint finalLength = length1 + length2;

        uint[] memory returnArray = new uint[](finalLength);

        for (uint i = 0; i < length1; i++) {
            returnArray[i] = arr1[i];
        }

        for (uint j = 0; j < length2; j++) {
            returnArray[length1 + j] = arr2[j];
        }

        return returnArray;
    }

    /**
     * @dev Iterates an array and returns true if the specified value is present in the array
     */
    function contains(uint[] memory arr, uint value) public pure returns (bool) {
        uint length = arr.length;

        for (uint i = 0; i < length; i++) {
            if (arr[i] == value) return true;
        }
        return false;
    }

    /**
     * @dev Iterates an array and returns a new array with values for which the predicate returns false
     */
    function filter(uint[] memory arr, bytes4 cb) public view returns (uint[] memory) {
        uint length = arr.length;
        uint offset = 0;
        uint[] memory filterArray = new uint[](length);

        for (uint i = 0; i < length; i++) {
            (bool success, bytes memory data) = msg.sender.staticcall(abi.encodeWithSelector(cb, arr[i]));

            require(success, "callback failed");
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
     * @dev Iterates an array and returns a new array of equal lenth containing transformed elements
     */
    function map(uint[] memory arr, bytes4 cb) public view returns (uint[] memory) {
        uint length = arr.length;
        uint[] memory returnArray = new uint[](length);

        for (uint i = 0; i < length; i++) {
            (bool success, bytes memory data) = msg.sender.staticcall(abi.encodeWithSelector(cb, arr[i]));

            require(success, "callback failed");
            returnArray[i] = bytesToUint(data, 0x00);
        }

        return returnArray;
    }

    /**
     * @dev Returns a sub-array of the input array inclusive of start end exclusive of end
     **/
    function slice(uint[] memory arr, uint start, uint end) public pure returns (uint[] memory) {
        require(end > start, "start must be before end");
        uint sliceLength = end - start;
        uint[] memory returnArray = new uint[](sliceLength);

        for (uint i = 0; i < sliceLength; i++) {
            returnArray[i] = arr[i + start];
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

            if (!this.contains(returnArray, value)) {
                returnArray[i - offset] = value;
            } else {
                offset++;
            }
        }

        return trim(length - offset, returnArray);
    }

    // Converts bytes into bool
    function bytesToBool(bytes memory data) internal pure returns(bool) {
        uint val = bytesToUint(data, 0x00);
        require(val == 0 || val == 1, "Predicate returned non-boolean value");

        return val == 1;
    }

    // Converts bytes into uint
    function bytesToUint(bytes memory data, uint start) internal pure returns (uint) {
        require(data.length >= start + 32, "slicing out of range");
        uint val;
        assembly {
            val := mload(add(data, add(0x20, start)))
        }
        return val;
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

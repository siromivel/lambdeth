pragma solidity ^0.5.0;

import "./Lambdeth.sol";


/**
 * @title LambdethTest
 * @dev Wrapper contract for testing Lambdeth methods. Necessary for passing bytes4 function signature.
 */
contract LambdethTest {

    function testConcat(Lambdeth lambdeth) public pure returns (uint[] memory) {
        uint[] memory testArr1 = new uint[](5);
        testArr1[0] = 1;
        testArr1[1] = 2;
        testArr1[2] = 3;
        testArr1[3] = 4;
        testArr1[4] = 5;

        uint[] memory testArr2 = new uint[](6);
        testArr2[0] = 6;
        testArr2[1] = 7;
        testArr2[2] = 8;
        testArr2[3] = 9;
        testArr2[4] = 0;
        testArr2[5] = 10;

        return lambdeth.concat(testArr1, testArr2);
    }

    function testContains(Lambdeth lambdeth) public pure returns (bool[] memory) {
        uint[] memory testArr = new uint[](10);
        testArr[0] = 1;
        testArr[1] = 2;
        testArr[2] = 3;
        testArr[3] = 300;
        testArr[4] = 7000;
        testArr[5] = 16;
        testArr[6] = 32;
        testArr[7] = 64;
        testArr[8] = 128;
        testArr[9] = 0;

        bool[] memory result = new bool[](2);

        result[0] = lambdeth.contains(testArr, 128);
        result[1] = lambdeth.contains(testArr, 17);

        return result;
    }

    function testFilter(Lambdeth lambdeth) public view returns (uint[] memory) {
        uint[] memory testArr = new uint[](10);
        testArr[0] = 1;
        testArr[1] = 2;
        testArr[2] = 3;
        testArr[3] = 300;
        testArr[4] = 7000;
        testArr[5] = 16;
        testArr[6] = 32;
        testArr[7] = 64;
        testArr[8] = 128;
        testArr[9] = 0;

        return lambdeth.filter(testArr, this.isNotAPowerOfTwo.selector);
    }

    function testMap(Lambdeth lambdeth) public view returns (uint[] memory) {
        uint[] memory testArr = new uint[](10);
        testArr[0] = 1;
        testArr[1] = 2;
        testArr[2] = 3;
        testArr[3] = 300;
        testArr[4] = 7000;
        testArr[5] = 16;
        testArr[6] = 32;
        testArr[7] = 64;
        testArr[8] = 128;
        testArr[9] = 0;

        return lambdeth.map(testArr, this.square.selector);
    }

    function testSlice(Lambdeth lambdeth) public pure returns (uint[] memory) {
        uint[] memory testArr = new uint[](10); 
        testArr[0] = 1;
        testArr[1] = 2;
        testArr[2] = 3;
        testArr[3] = 300;
        testArr[4] = 7000;
        testArr[5] = 16;
        testArr[6] = 32;
        testArr[7] = 64;
        testArr[8] = 128;
        testArr[9] = 0;

        return lambdeth.slice(testArr, 3, 7);
    }

    function testUnique(Lambdeth lambdeth) public view returns (uint[] memory) {
        uint[] memory testArr = new uint[](10);
        testArr[0] = 1;
        testArr[1] = 5;
        testArr[2] = 1;
        testArr[3] = 13;
        testArr[4] = 13;
        testArr[5] = 17;
        testArr[6] = 21;
        testArr[7] = 10;
        testArr[8] = 17;
        testArr[9] = 10;

        return lambdeth.unique(testArr);
    }

    function square(uint n) public pure returns (uint) {
        return n ** 2;
    }

    function isNotAPowerOfTwo(uint n) public pure returns (bool) {
        return n % 2 != 0;
    }
}

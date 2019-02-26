pragma solidity ^0.5.0;

import './Lambdeth.sol';


/**
 * @title LambdethTest
 * @dev Wrapper contract for testing Lambdeth methods. Necessary for passing bytes4 function signature.
 */
contract LambdethTest {

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

        return lambdeth.filter(address(this), testArr, this.isNotAPowerOfTwo.selector);
    }

    function testFind(Lambdeth lambdeth) public pure returns (bool[] memory) {
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

        result[0] = lambdeth.find(testArr, 128);
        result[1] = lambdeth.find(testArr, 17);

        return result;
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

        return lambdeth.map(address(this), testArr, this.square.selector);
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

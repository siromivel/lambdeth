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

    function square(uint n) public pure returns (uint) {
        return n ** 2;
    }

    function isNotAPowerOfTwo(uint n) public pure returns (bool) {
        return n % 2 != 0;
    }
}

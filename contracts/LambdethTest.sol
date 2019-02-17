pragma solidity ^0.5.0;

import './Lambdeth.sol';


contract LambdethTest {
    function testMap(Lambdeth lambdeth) public view returns (uint[] memory) {
        uint[] memory testArr = new uint[](3);
        testArr[0] = 1;
        testArr[1] = 2;
        testArr[2] = 3;

        return lambdeth.map(address(this), testArr, this.square.selector);
    }

    function square(uint n) public pure returns (uint) {
        return n ** n;
    }

    function isTwo(uint n) public pure returns (bool) {
        return n == 2;
    }

    function testFilter(Lambdeth lambdeth) public view returns (uint[] memory) {
        uint[] memory testArr = new uint[](3);
        testArr[0] = 1;
        testArr[1] = 2;
        testArr[2] = 3;

        return lambdeth.filter(address(this), testArr, this.isTwo.selector);
    }
}

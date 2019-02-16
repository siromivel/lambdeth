pragma solidity ^0.5.0;

import "../Lambdeth.sol";

contract LambdethMock {
  function map(address sender, uint256[] memory arr, bytes4 cb) public returns (uint[] memory) {
    return Lambdeth.map(sender, arr, cb);
  }
}

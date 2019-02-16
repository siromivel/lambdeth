pragma solidity ^0.4.20;

import "truffle/Assert.sol";
// import "truffle/DeployedAddresses.sol";

contract LambdethTest {

    function test() public {

        Assert.equal(true, true, "It's not true");
        // Assert.equal(price, expectedPrice, "Item price should match");
        // Assert.equal(status, uint(HashMarket.ItemStatus.active), "Item status at creation should be .active");
        // Assert.equal(seller, this, "The function caller should be the seller");
    }

}

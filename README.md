# Lambdeth

Lambdeth is a functional library built in Solidity. It uses tools from ZeppelinOS and Truffle.

Currently deployed to Ropsten through ZeppelinOS at proxy address `0xC729f82F798cA120d2b31215cB0a1322811Af9D1`.

## Methods

### Concat
Returns a new array containing all elements from two input arrays.

### Contains
Returns true if a specified value is present in the array and false if not.

### Map
Returns a new array of equal lenth containing transformed elements.

### Filter
Returns a new array with values for which the predicate returns false.

### Unique
Returns a new array containing only 1 copy of each value present in the original array.
____________________________________________________________________________________________________________________________________
# Usage

This library relies on ZeppelinOS and Truffle, as well as the software that supports these services. However, The necessary depenedencies should be contained in the files and no installations should be necessary for use.

To use a function from the library:
    Lambdeth.{functionName}
    
 A note about gas:
 You will pay gas in order to use these functions.

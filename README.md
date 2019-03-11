# Lambdeth

Lambdeth is a functional library built in Solidity. It uses tools from ZeppelinOS and Truffle.

## Methods

### concat(uint[], uint[])
Returns a new array containing all elements from two input arrays.

### contains(uint[], uint value)
Returns true if a specified value is present in the array and false if not.

### filter(uint[], bytes4 callback)
Returns a new array with values for which the predicate returns false.
Callback must be passed as a bytes4 function selector.

### map(uint[], bytes4 callback)
Returns a new array of equal lenth containing transformed elements.
Callback must be passed as a bytes4 function selector and must return a bool.

### slice(uint[], uint start, uint end)
Returns a new array containing a specified subset of the original array; inclusive of start and exclusive of end.

### unique(uint[])
Returns a new array containing only 1 copy of each value present in the original array.
____________________________________________________________________________________________________________________________________
# Usage

This library relies on ZeppelinOS and Truffle, as well as the software that supports these services. However, The necessary depenedencies should be contained in the files and no installations should be necessary for use.

To use a function from the library:
    Lambdeth.{functionName}
    
 A note about gas:
 You will pay gas in order to use these functions.

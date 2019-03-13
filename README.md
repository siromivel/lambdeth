# Lambdeth

Lambdeth is a functional library built in Solidity.

Install for use through ZeppelinOS via npm: https://www.npmjs.com/package/lambdeth

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

Install via NPM for use in projects built on ZeppelinOS: `npm install lambdeth`.

To use a function from the library:
    Lambdeth.{functionName}

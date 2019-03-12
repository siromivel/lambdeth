'use strict'
process.env.NODE_ENV = 'test'

const Lambdeth = artifacts.require('Lambdeth')
const LambdethMethodTest = artifacts.require('LambdethMethodTest')

contract('Lambdeth', function () {
  beforeEach(async function () {
    this.lambdeth = await Lambdeth.new({ gas: 5000000 })
    this.lambdethTest = await LambdethMethodTest.new({ gas: 5000000 })
  })

  describe('concat', function() {
    it('should concatenate two arrays', async function() {
      const expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 10]
      const result = await this.lambdethTest.testConcat(this.lambdeth.address)

      expect(transformSolidityArray(result)).to.eql(expected)
    })
  })

  describe('contains', function() {
    it('should return true if an array contains the passed value', async function() {
      const result = await this.lambdethTest.testContains(this.lambdeth.address)

      expect(result).to.eql([true, false])
    })
  })

  describe('filter', function() {
    it('should return an array containing only elements for which the predicate function returns true', async function() {
      const expected = [1, 3]
      const result = await this.lambdethTest.testFilter(this.lambdeth.address)

      expect(transformSolidityArray(result)).to.eql(expected)
    })
  })

  describe('map', function() {
    it('should transform an array by applying a callback on every element', async function() {
      const expected = [1**2, 2**2, 3**2, 300**2, 7000**2, 16**2, 32**2, 64**2, 128**2, 0**2]
      const result = await this.lambdethTest.testMap(this.lambdeth.address)

      expect(transformSolidityArray(result)).to.eql(expected)
    })
  })

  describe('slice', function() {
    it('should return a sub-array inclusive of start and exclusive of end', async function() {
      const expected = [300, 7000, 16, 32]
      const result = await this.lambdethTest.testSlice(this.lambdeth.address)

      expect(transformSolidityArray(result)).to.eql(expected)
    })
  })

  describe('unique', function() {
    it('should return an array containing only one copy of each value', async function() {
      let expected = [1, 5, 13, 17, 21, 10, 0]
      let result = await this.lambdethTest.testUnique(this.lambdeth.address)

      expect(transformSolidityArray(result)).to.eql(expected)
    })

    it('should handle arrays with a 0 in the last position', async function() {
      let expected = [2, 1, 0]
      let result = await this.lambdethTest.testUniqueWithTrailingZero(this.lambdeth.address)

      expect(transformSolidityArray(result)).to.eql(expected)
    })
  })

  
})

function transformSolidityArray(arr) {
  return arr.map(val => val.words[0])
}

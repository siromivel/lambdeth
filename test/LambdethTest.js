'use strict'
process.env.NODE_ENV = 'test'

const Lambdeth = artifacts.require('Lambdeth')
const LambdethTest = artifacts.require('LambdethTest')

contract('Lambdeth', function () {
  beforeEach(async function () {
    this.lambdeth = await Lambdeth.new({ gas: 5000000 })
    this.lambdethTest = await LambdethTest.new({ gas: 5000000 })
  })

  it('should concatenate two arrays', async function() {
    const expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 10]
    const result = await this.lambdethTest.testConcat(this.lambdeth.address)

    expect(transformSolidityArray(result)).to.eql(expected)
  });

  it('should transform an array', async function() {
    const expected = [1**2, 2**2, 3**2, 300**2, 7000**2, 16**2, 32**2, 64**2, 128**2, 0**2]
    const result = await this.lambdethTest.testMap(this.lambdeth.address)

    expect(transformSolidityArray(result)).to.eql(expected)
  })

  it('should filter an array', async function() {
    const expected = [1, 3]
    const result = await this.lambdethTest.testFilter(this.lambdeth.address)

    expect(transformSolidityArray(result)).to.eql(expected)
  })

  it('should return true if an array contains the passed value', async function() {
    const result = await this.lambdethTest.testContains(this.lambdeth.address)

    expect(result).to.eql([true, false])
  });

  it('should slice an array', async function() {
    const expected = [300, 7000, 16, 32]
    const result = await this.lambdethTest.testSlice(this.lambdeth.address)

    expect(transformSolidityArray(result)).to.eql(expected)
  });

  it('should unique an array', async function() {
    const expected = [1, 5, 13, 17, 21, 10]
    const result = await this.lambdethTest.testUnique(this.lambdeth.address)

    expect(transformSolidityArray(result)).to.eql(expected)
  });
})

function transformSolidityArray(arr) {
  return arr.map(val => val.words[0])
}

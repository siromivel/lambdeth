'use strict'
process.env.NODE_ENV = 'test'

const assert = require('chai').expect
const zosLib = require('zos-lib')
const zos = require('zos')
zosLib.ZWeb3.initialize(web3.currentProvider)

const Lambdeth = artifacts.require('Lambdeth')
const LambdethTest = artifacts.require('LambdethTest')
const TestHelper = zos.TestHelper

contract('Lambdeth', function ([_, owner]) {
  beforeEach(async function () {
    this.project = await TestHelper({from: owner})

    this.lambdeth = await Lambdeth.new({ gas: 5000000 })
    this.lambdethTest = await LambdethTest.new({ gas: 5000000 })
  })

  it('should transform an array', async function () {
    const expected = [1**2, 2**2, 3**2, 300**2, 7000**2, 16**2, 32**2, 64**2, 128**2, 0**2]
    const result = await this.lambdethTest.testMap(this.lambdeth.address)

    expect(transformSolidityArray(result)).to.eql(expected)
  })

  it('should filter an array', async function() {
    const expected = [1, 3]
    const result = await this.lambdethTest.testFilter(this.lambdeth.address)

    expect(transformSolidityArray(result)).to.eql(expected)
  })

  it('should find a value in an array', async function() {
    const result = await this.lambdethTest.testFind(this.lambdeth.address);

    expect(result).to.eql([true, false]);
  });

  it('should unique an array', async function() {
    const expected = [1, 5, 13, 17, 21, 10];
    const result = await this.lambdethTest.testUnique(this.lambdeth.address);

    expect(transformSolidityArray(result)).to.eql(expected);
  });
})

function transformSolidityArray(arr) {
  return arr.map(val => val.words[0])
}

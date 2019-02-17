'use strict'
process.env.NODE_ENV = 'test'

const assert = require('chai').expect
const zosLib = require('zos-lib')
const zos = require('zos')
zosLib.ZWeb3.initialize(web3.currentProvider)

// const Lambdeth = zosLib.Contracts.getFromLocal('Lambdeth')
const Lambdeth = artifacts.require('Lambdeth')
const LambdethTest = artifacts.require('LambdethTest')
const TestHelper = zos.TestHelper

contract('Lambdeth', function ([_, owner]) {
  beforeEach(async function () {
    this.project = await TestHelper({from: owner})

    this.lambeth = await Lambdeth.new({ gas: 5000000 })
    this.lambdethTest = await LambdethTest.new({ gas: 5000000 })
  })

  it('should transform an array', async function () {
    const result = await this.lambdethTest.testMap(this.lambeth.address)

    expect(transformSolidityArray(result)).to.eql([1, 4, 27])
  })

  it('should filter an array', async function() {
    const result = await this.lambdethTest.testFilter(this.lambeth.address)

    expect(transformSolidityArray(result)).to.eql([1, 3])
  })
})

function transformSolidityArray(arr) {
  return arr.map(val => val.words[0])
}

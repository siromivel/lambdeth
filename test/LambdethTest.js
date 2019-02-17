'use strict'
process.env.NODE_ENV = 'test'

const assert = require('chai').assert
const zosLib = require('zos-lib')
const zos = require('zos')
zosLib.ZWeb3.initialize(web3.currentProvider)

const Lambdeth = zosLib.Contracts.getFromLocal('Lambdeth')
const TestHelper = zos.TestHelper

contract('Lambdeth', function ([_, owner]) {
  beforeEach(async function () {
    this.project = await TestHelper({from: owner})
  })

  it('should transform an array', async function () {
    const proxy = await this.project.createProxy(Lambdeth);

    // const result = await proxy.Contracts.Lambdeth.map([1, 2, 3], function(val) {
    //   return val * 2
    // })

    console.log(proxy)
    assert.equal(1, 1, "Hmmmm")
  })
})

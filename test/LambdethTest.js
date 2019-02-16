import { TestHelper } from 'zos'

require('chai').should()

const Lambdeth = artifacts.require('Lambdeth')
const TestHelper = Zos.TestHelper

contract('Lambdeth', function ([_, owner]) {
  beforeEach(async function () {
    this.project = await TestHelper({from: owner})
  })

  it('should transform an array', async function () {
    const proxy = await this.project.createProxy(Lambdeth)
    const result = await proxy.map([1, 2, 3], function(val) {
      return val * 2
    })

    console.log(result)

  }
)

})

const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Deploy Gas Challenge Contract", () => {
  let gas_contract;

  beforeEach(async () => {
    const gas_challenge_contract = await ethers.getContractFactory(
      "gasChallenge"
    );
    gas_contract = await gas_challenge_contract.deploy();
  });

  describe("Compute Gas", () => {
    it("Should return lower gas", async () => {
      await gas_contract.notOptimizedFunction();
      await gas_contract.optimizedFunction();
    });
  });

  describe("Check Sum Of Array", () => {
    it("Should return 0", async () => {
      // Call the optimizedFunction to calculate the sum of the array
      await gas_contract.optimizedFunction();
      
      // Call the getSumOfArray function to check the sum after optimization
      const sumAfterOptimization = await gas_contract.getSumOfArray();
      
      // Assert that the sum of the array is 0
      expect(sumAfterOptimization).to.equal(0);
    });
  });
});

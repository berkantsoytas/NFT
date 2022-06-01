const { assert } = require("chai");

require("chai").use(require("chai-as-promised")).should();

const KryptoBird = artifacts.require("Kryptobird");

contract("KryptoBird", async (accounts) => {
  let contract;
  before(async () => {
    contract = await KryptoBird.deployed();
  });

  describe("deployment", async () => {
    // test samples with writing it
    it("deploys successfully", async () => {
      const address = contract.address;

      assert.notEqual(address, 0x0);
      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
    });

    it("has a name and symbol", async () => {
      const name = await contract.name();
      const symbol = await contract.symbol();

      assert.equal(name, "Kryptobird");
      assert.equal(symbol, "KRB");
    });
  });

  describe("minting", async () => {
    it("create a new token", async () => {
      const result = await contract.mint("https...1");
      const totalSupply = await contract.totalSupply();

      // success
      assert.equal(totalSupply.toNumber(), 1);

      const event = result.logs[0].args;
      assert.equal(
        event._from,
        "0x0000000000000000000000000000000000000000",
        "from is the contract address"
      );

      assert.equal(event._to, accounts[0], "to is the owner");

      // failure
      await contract.mint("https...1").should.be.rejected;
    });
  });

  describe("indexing", async () => {
    it("list KryptoBird", async () => {
      await contract.mint("https...2");
      await contract.mint("https...3");
      await contract.mint("https...4");

      const totalSupply = await contract.totalSupply();

      let result = [];
      let KryptoBird;

      for (i = 1; i <= totalSupply; i++) {
        KryptoBird = await contract.kryptoBirdz(i - 1);
        result.push(KryptoBird);
      }

      // assert that the result is an array
      let expected = ["https...1", "https...2", "https...3", "https...4"];
      assert.equal(result.join(","), expected.join(","));
    });
  });
});

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PersonhoodRegistry", function () {
  let registry, owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const Registry = await ethers.getContractFactory("PersonhoodRegistry");
    registry = await Registry.deploy();
    await registry.waitForDeployment();
  });

  it("should register a commitment", async function () {
    const commitment = ethers.keccak256(ethers.toUtf8Bytes("test-identity"));
    await expect(registry.register(commitment))
      .to.emit(registry, "Registered")
      .withArgs(owner.address, commitment);
    expect(await registry.isRegistered(commitment)).to.equal(true);
  });

  it("should not allow duplicate commitments", async function () {
    const commitment = ethers.keccak256(ethers.toUtf8Bytes("dup"));
    await registry.register(commitment);
    await expect(registry.connect(addr1).register(commitment))
      .to.be.revertedWith("Commitment already exists");
  });

  it("should track user count", async function () {
    const c1 = ethers.keccak256(ethers.toUtf8Bytes("user1"));
    const c2 = ethers.keccak256(ethers.toUtf8Bytes("user2"));
    await registry.register(c1);
    await registry.connect(addr1).register(c2);
    expect(await registry.getUserCount()).to.equal(2);
  });
});

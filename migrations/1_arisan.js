var Arisan = artifacts.require("Arisan");

module.exports = function(deployer) {
  const arisanAmount = web3.utils.toWei('0.1', 'ether'); // Example: 1 Ether
  deployer.deploy(Arisan, arisanAmount, ["0x8c6b11540F6387D0A401F0DE906ceB81ca9d14Df", "0xAeDee5fe889701d4cFC5A1e1f40764B0C8cc6b9F", "0xC49d2Ab0284aF38432BBf58D233e11B3461e2b1E"]); 
};

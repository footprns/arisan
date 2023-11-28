var Arisan = artifacts.require("Arisan");

module.exports = function(deployer) {
  const arisanAmount = web3.utils.toWei('1', 'ether'); // Example: 1 Ether
  deployer.deploy(Arisan, arisanAmount); 
};

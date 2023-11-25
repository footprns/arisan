var Arisan = artifacts.require("Arisan");

module.exports = function(deployer) {
  deployer.deploy(Arisan, ['0xa1b6cBe08111e46bf7B4da578505C17EdA3867B3', '0x46B86C0f9de2469d076533CE1605E5F6DAd6d377', '0x1E5E4346b00AbCe4ec93d6Be9729AFf985A2D2F0']); 
};

var Remittance = artifacts.require("./Remittance.sol");

module.exports = function(deployer) {
  deployer.deploy(Remittance,
    web3.eth.accounts[1],
    "0x4d0412f96db71b59f870c13d1dd57c528e1f0def2c2e7fe907282607cff416b2",
    {from:web3.eth.accounts[0], value:256});
};

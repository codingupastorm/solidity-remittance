var Remittance = artifacts.require("./Remittance.sol");

module.exports = function(deployer) {
  deployer.deploy(Remittance,
    web3.eth.accounts[1],
    "0x0f35057082c0e94cb82f0135c5d2f1925bd6c9a4d285b0fe68cd132dfb30f773",
    "0x7c0007d6a4d78c9ba13d467a66ab49a7b8f4a3dcf0d8f3c38e89b542ad62fbbf",
    {from:web3.eth.accounts[0], value:256});
};

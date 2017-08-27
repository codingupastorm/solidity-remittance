var Remittance = artifacts.require('./Remittance.sol');

contract('Remittance', function(accounts) {
  var remittance;
  const alice = accounts[0];
  const bob = accounts[1];
  const carol = accounts[2];

  beforeEach("deploy a Remittance contract", function() {
    return Remittance.new({from: alice}).then(_remittance => remittance = _remittance);
  });

  // it("should work end to end", function() {
  //   remittance.createNew(bob, bytes32 pHash, uint duration)
  //   var carolBalance = web3.eth.getBalance(carol).toNumber();
  //   return Remittance.deployed().then(function(instance) {
  //     return instance.withdraw("0x0f35057082c0e94cb82f0135c5d2f1925bd6c9a4d285b0fe68cd132dfb30f773",
  //         "0x7c0007d6a4d78c9ba13d467a66ab49a7b8f4a3dcf0d8f3c38e89b542ad62fbbf",
  //         {from: carol});
  //   }).then(function(tx) {
  //     //need to check the balance difference + account for gas!
  //     console.log(web3.eth.getBalance(carol).toNumber());
  //   });
  // });
});

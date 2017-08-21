var Remittance = artifacts.require('./Remittance.sol');

contract('Remittance', function(accounts) {
  const alice = accounts[0];
  const carol = accounts[1];

  it("should allow withdrawal", function() {
    var carolBalance = web3.eth.getBalance(carol).toNumber();
    console.log(carolBalance);
    return Remittance.deployed().then(function(instance) {
      return instance.withdraw("0x0f35057082c0e94cb82f0135c5d2f1925bd6c9a4d285b0fe68cd132dfb30f773",
          "0x7c0007d6a4d78c9ba13d467a66ab49a7b8f4a3dcf0d8f3c38e89b542ad62fbbf",
          {from: carol});
    }).then(function(tx) {
      console.log(web3.eth.getBalance(carol).toNumber());
      // assert.equal(web3.eth.getBalance(carol).toNumber(),
      // carolBalance + afterSplit, "Balance didn't increase by " + afterSplit);
    });
  });
});

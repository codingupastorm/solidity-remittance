pragma solidity ^0.4.6;

contract Remittance {
    address public withdrawer;
    uint public amountHeld;
    bytes32 passHash;

    function Remittance(address allowedWithdrawer, bytes32 pHash) payable {
        withdrawer = allowedWithdrawer;
        amountHeld = msg.value;
        passHash = pHash;
    }

    function withdraw(bytes32 passHash1, bytes32 passHash2) payable returns(bool){
      require(msg.sender == withdrawer);
      require(passHash == keccak256(passHash1, passHash2));
      withdrawer.send(amountHeld);
      amountHeld = 0;
      return true;
    }
}

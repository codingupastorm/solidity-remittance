pragma solidity ^0.4.6;

contract Remittance {
    address public withdrawer;
    uint public amountHeld;
    bytes32 passHash;

    function Remittance(address allowedWithdrawer, bytes32 passHash1, bytes32 passHash2) payable {
        withdrawer = allowedWithdrawer;
        amountHeld = msg.value;
        passHash = keccak256(passHash1, passHash2);
    }

    function withdraw(bytes32 passHash1, bytes32 passHash2) payable returns(bool){
      if (msg.sender != withdrawer) throw;
      if (passHash != keccak256(passHash1, passHash2)) throw;
      withdrawer.send(amountHeld);
      return true;
    }
}

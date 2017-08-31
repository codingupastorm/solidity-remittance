pragma solidity ^0.4.6;

import "./Owned.sol";

contract Remittance is Owned {

    struct RemittanceStruct{
      uint amount;
      bytes32 recipientHidden;
      address owner;
      uint deadline;
    }

    mapping(bytes32 => RemittanceStruct) public remittances;
    uint public constant maxDeadlineDuration = 100;

    event LogNewRemittance(address indexed from, address to, uint256 amount);
    event LogRemittanceClaimed(address indexed caller, uint256 amount);
    event LogRemittanceRefunded(address indexed caller, uint256 amount);
    event LogKilled();

    function createNew(bytes32 to, bytes32 pHash, uint duration) public payable returns (bool) {
        require(remittances[pHash].owner == address(0)); // pass has not been used before
        require(msg.value > 0);
        require(duration <= maxDeadlineDuration);
        remittances[pHash] = RemittanceStruct(msg.value, to, msg.sender, block.number + duration);
        LogNewRemittance(msg.sender, to, msg.value);
        return true;
    }

    function claim(bytes32 passHash1, bytes32 passHash2) public returns(bool){
      RemittanceStruct storage remittance = remittances[keccak256(passHash1, passHash2)];
      require(remittance.recipient == keccak256(msg.sender));
      require(remittance.amount > 0);
      require(remittance.deadline >= block.number);
      uint toSend = remittance.amount;
      remittance.amount = 0;
      msg.sender.transfer(toSend);
      LogRemittanceClaimed(msg.sender, toSend);
      return true;
    }

    function claimRefund(bytes32 pHash) public returns(bool){
      RemittanceStruct storage remittance = remittances[pHash];
      require(remittance.amount > 0);
      require(remittance.owner == msg.sender);
      require(remittance.deadline <= block.number);
      uint toSend = remittance.amount;
      remittance.amount = 0;
      msg.sender.transfer(toSend);
      LogRemittanceRefunded(msg.sender, toSend);
      return true;
    }

    //doesn't return any eth yet.
    function kill() onlyOwner {
      LogKilled();
      selfdestruct(this);
    }

}

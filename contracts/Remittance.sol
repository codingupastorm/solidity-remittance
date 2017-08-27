pragma solidity ^0.4.6;

contract Remittance {

    struct RemittanceStruct{
      uint amount;
      address recipient;
      address owner;
      bool claimed;
      uint deadline;
    }

    mapping(bytes32 => RemittanceStruct) public remittances;
    address public owner;
    uint public constant maxDeadlineDuration = 100;

    event LogNewRemittance(address indexed from, address to, uint256 amount);
    event LogRemittanceClaimed(address indexed caller, uint256 amount);
    event LogRemittanceRefunded(address indexed caller, uint256 amount);
    event LogKilled();

    function Remittance(){
      owner = msg.sender;
    }

    function createNew(address to, bytes32 pHash, uint duration) payable returns (bool) {
        require(remittances[pHash].amount == 0); // pass has not been used before
        require(msg.value > 0);
        require(duration <= maxDeadlineDuration);
        remittances[pHash] = RemittanceStruct(msg.value, to, msg.sender, false, block.number + duration);
        LogNewRemittance(msg.sender, to, msg.value);
        return true;
    }

    function claim(bytes32 passHash1, bytes32 passHash2) payable returns(bool){
      RemittanceStruct remittance = remittances[keccak256(passHash1, passHash2)];
      require(remittance.amount > 0); // is existing
      require(!remittance.claimed);
      require(remittance.recipient == msg.sender);
      require(remittance.deadline >= block.number);
      remittance.claimed = true;
      msg.sender.transfer(remittance.amount);
      LogRemittanceClaimed(msg.sender, remittance.amount);
      return true;
    }

    function claimRefund(bytes32 passHash1, bytes32 passHash2) payable returns(bool){
      RemittanceStruct remittance = remittances[keccak256(passHash1, passHash2)];
      require(remittance.amount > 0); // is existing
      require(!remittance.claimed);
      require(remittance.owner == msg.sender);
      require(remittance.deadline <= block.number);
      remittance.claimed = true;
      msg.sender.transfer(remittance.amount);
      LogRemittanceRefunded(msg.sender, remittance.amount);
      return true;
    }

    //doesn't return any eth yet.
    function kill(){
      require(msg.sender == owner);
      LogKilled();
      selfdestruct(this);
    }

}

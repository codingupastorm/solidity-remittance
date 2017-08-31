pragma solidity ^0.4.6;

contract Owned {
  address public owner = msg.sender;

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function Remittance(){
    owner = msg.sender;
  }
}

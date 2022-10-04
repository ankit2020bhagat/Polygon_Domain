// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;


import "hardhat/console.sol";

contract Domains {
 
  string public tld;

  mapping(string => address) public domains;
  mapping(string => string) public records;
		
  
  constructor(string memory _tld) payable {
    tld = _tld;
    console.log("%s name service deployed", _tld);
  }
	function strlen(string memory s) public pure returns ( uint256) {
        return bytes(s).length;
  }
  function price(string calldata name) public pure returns(uint) {
    uint len = strlen(name);
    require(len > 0);
    if (len == 3) {
      return 5 * 10**17; 
    } else if (len == 4) {
      return 3 * 10**17; 
    } else {
      return 1 * 10**17;
    }
  }

  function register(string calldata name) public payable{
    require(domains[name] == address(0));
    
    uint _price = price(name);

    // Check if enough Matic was paid in the transaction
    require(msg.value >= _price, "Not enough Matic paid");

    domains[name] = msg.sender;
    console.log("%s has registered a domain!", msg.sender);
  }

  function getAddress(string calldata name) public view returns (address) {
      return domains[name];
  }
}
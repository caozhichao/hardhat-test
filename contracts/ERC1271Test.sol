//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.4;

import "@openzeppelin/contracts/interfaces/IERC1271.sol";

contract ERC1271Test {
  int public v;
  constructor(){

  }

  function test1() pure public returns(bytes4){
    return IERC1271.isValidSignature.selector;
  }

  function setV(int v_) public {
    v = v_;
  }
}
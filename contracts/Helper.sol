//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

// interface IERC20 {
//     function transferFrom(
//         address from,
//         address to,
//         uint256 amount
//     ) external returns (bool);
// }

// interface IERC721 {
//   function transferFrom(
//         address from,
//         address to,
//         uint256 tokenId
//     ) external;
// }

interface ITransferFrom {
  function transferFrom(
        address from,
        address to,
        uint256 value
    ) external;
}


contract Helper is Ownable {

  struct Data{
    address tokenAddress;
    address from;
    address to;
    uint256 value; /* amount tokenId */
  }
  struct Data2{
    address tokenAddress;
    bytes data;
  }

  event SuccessEvent();
  event SuccessEvent2(bytes);
  event FailEvent();
  // constructor() payable{

  // }
  
  function batchTransferFrom(Data[] memory arr) public  onlyOwner returns (bool){
    // require(msg.sender == owner,"Not owner");
    for(uint i = 0; i < arr.length;i++){
      Data memory d = arr[i];
      // IERC20(d.tokenAddress).transferFrom(d.from, d.to, d.value);
      try ITransferFrom(d.tokenAddress).transferFrom(d.from,d.to,d.value) {
        emit SuccessEvent();
      } catch {
        emit FailEvent();
      }
    }
    return true;
  }

  function batchCall(Data2[] calldata arr) public  onlyOwner returns (bool){
    for(uint i = 0; i < arr.length;i++){
      Data2 memory d = arr[i];
      (bool success,bytes memory res) = d.tokenAddress.call(d.data);
      if(success){
        emit SuccessEvent2(res);
      } else {
        emit FailEvent();
      }
    }
    return true;
  }
   function encodeWithSignature(address from,address to,uint256 value) public pure returns(bytes memory){
      return abi.encodeWithSignature("transferFrom(address,address,uint256)",from,to,value);
   }

  function withdraw() public onlyOwner {
      uint balance = address(this).balance;
      payable(msg.sender).transfer(balance);
  }
  function getBalance() public view  returns (uint256){
    return address(this).balance;
  }
  receive () external payable {}
  fallback () external payable {}
}
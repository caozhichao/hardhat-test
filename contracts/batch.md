
# 批量转移nftfi凭证合约 Demo 演示
## 环境 [remix](https://remix.ethereum.org)
## [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts)
## 合约准备
1. 部署一个erc20合约
2. 部署一个erc721合约
3. 部署一个批量转账合约  合约地址作为转账的主体地址(vault钱包)
## 用例
1. 准备一个erc20钱包地址，并对vault钱包地址 approve 
2. 准备一个erc721钱包地址，并对vault钱包地址 setApproveForAll
3. 准备一个接收钱包地址to 
4. 执行批量转账 batchTransferFrom

```js
REC20Test.sol

//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract ERC20Test is ERC20 {
    event Log(address sender, address from,address to,uint256 amount);
    constructor(uint256 _totalSuperNum) ERC20("test","T") {
        _mint(msg.sender,_totalSuperNum);
    }
}

ERC721Test.sol

//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract ERC721Test is ERC721 {
    address public owner;
    constructor() ERC721("test_nft","NFT") {
        owner = msg.sender;
    }
    function mint(address to, uint256 tokenId) public {
        require(msg.sender == owner,"Not owner");
        _mint(to, tokenId);
    }
}

Helper.sol

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

  constructor() payable{

  }

  function batchTransferFrom(Data[] memory arr) public  onlyOwner returns (bool){
    // require(msg.sender == owner,"Not owner");
    for(uint i = 0; i < arr.length;i++){
      Data memory d = arr[i];
      // IERC20(d.tokenAddress).transferFrom(d.from, d.to, d.value);
      // IERC721(d.tokenAddress).transferFrom(d.from,d.to,d.value);
      ITransferFrom(d.tokenAddress).transferFrom(d.from,d.to,d.value);
    }
    return true;
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

```

erc20:0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
to:0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
vault:批量转账合约地址 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8

0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8

[["0x3328358128832A260C76A4141e19E2A943CD4B6D","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",50]]

[["0xd2a5bC10698FD955D1Fe6cb468a17809A08fd005","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",2]]

[["0xd9145CCE52D386f254917e481eB44e9943F39138","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",50],["0xb27A31f1b0AF2946B7F582768f03239b1eC07c2c","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",2]]

[["0xDA0bab807633f07f013f94DD0E6A4F96F8742B53","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",100]]

[["0xDA0bab807633f07f013f94DD0E6A4F96F8742B53","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",100],["0xDA0bab807633f07f013f94DD0E6A4F96F8742B53","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",200]]



0x23b872dd0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb20000000000000000000000000000000000000000000000000000000000000064

[["0xb27A31f1b0AF2946B7F582768f03239b1eC07c2c","0x23b872dd0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb20000000000000000000000000000000000000000000000000000000000000064"]]
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract ERC20Test is ERC20 {
    constructor(uint256 _totalSuperNum,string memory name_, string memory symbol_) ERC20(name_,symbol_) {
        _mint(msg.sender,_totalSuperNum);
    }
}
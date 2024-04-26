// @author: proteanx <pro@proteanx.com>
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// @dev: This contract is a simple token minting contract that allows anyone to mint tokens.
// It is intended to mimmick the behavior of minting brc20 or runes tokens on bitcoin
contract MyToken is ERC20 {
    uint256 public maxSupply;
    uint256 public mintAmount;
    uint256 public totalMints;
    
    constructor() ERC20("Open Mint", "OMINT") (
        uint256 _maxSupply;
        uint256 _mintAmount;
    ) {
        maxSupply = _maxSupply;
        mintAmount = _mintAmount;
    }

    function publicMint() public {
        require(totalSupply() + mintAmount <= maxSupply, "Max supply reached");
        _mint(msg.sender, mintAmount);
        totalMints += 1;
    }
    
}


// @author: proteanx <pro@proteanx.com>
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// @dev: This contract is a simple token minting contract that allows anyone to mint tokens.
// It is intended to mimmick the behavior of minting brc20 or runes tokens on bitcoin
contract OpenMint is ERC20 {
    uint256 public maxSupply;
    uint256 public mintAmount;
    uint256 public totalMints;
    uint256 public totalBurns;
    uint256 public startBlock;
    uint256 public endBlock;
    uint256 public maxMints;
    
    constructor() ERC20("Open Mint", "OMINT") (
        uint256 _maxMints;
        uint256 _mintAmount;
        uint256 _startBlock;
        uint256 _endBlock;
    ) {
        maxMints = _maxMints;
        mintAmount = _mintAmount;
        startBlock = _startBlock;
        endBlock = _endBlock;
    }

    maxSupply = maxMints * mintAmount;

    function publicMint() public {
        require(block.number >= startBlock && block.number <= endBlock, "Mint not in progress");
        require(totalMints <= maxMints, "Maximum mints reached");
        _mint(msg.sender, mintAmount);
        totalMints += 1;
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        totalBurns += amount;
    }
    
    function burnFrom(address from, uint256 amount) public {
        _burn(from, amount);
        totalBurns += amount;
    }
}


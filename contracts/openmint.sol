// @author: proteanx <pro@proteanx.com>
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// @dev: This contract is a simple token contract that allows anyone to mint tokens.
// It is intended to mimmick the behavior of minting brc20 or runes tokens on bitcoin.
// Additional features are the ability to burn tokens. 
contract OpenMint is ERC20 {
    uint256 public maxSupply;
    uint256 public mintAmount;
    uint256 public totalMints;
    uint256 public totalBurns;
    uint256 public startBlock;
    uint256 public endBlock;
    uint256 public maxMints;
    
    mapping(address => uint256) public lastMintBlock;
    
    constructor(
        uint256 _maxMints,
        uint256 _mintAmount,
        uint256 _startBlock,
        uint256 _endBlock
    ) ERC20("Open Mint", "OMINT") {
        maxMints = _maxMints;
        mintAmount = _mintAmount;
        require(_endBlock > _startBlock, "End block must be greater than start block");
        require(_endBlock > block.number, "End block must be in the future");
        startBlock = _startBlock;
        endBlock = _endBlock;
        maxSupply = maxMints * mintAmount;
    }

    event Minted(address indexed minter);
    event Burned(address indexed burner, uint256 amount);

    function mintsRemaining() public view returns (uint256) {
        if (block.number > endBlock) {
            return 0;
        }
        return maxMints - totalMints;
    }
    
    function publicMint() public {
        require(block.number >= startBlock && block.number <= endBlock, "Mint not in progress");
        require(totalMints < maxMints, "Maximum mints reached");
        require(block.number > lastMintBlock[msg.sender] + 1, "Must wait 1 block between mints");
        
        _mint(msg.sender, mintAmount);
        totalMints += 1;
        lastMintBlock[msg.sender] = block.number;

        emit Minted(msg.sender);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        totalBurns += amount;

        emit Burned(msg.sender, amount);
    }
    
    function burnFrom(address from, uint256 amount) public {
        _burn(from, amount);
        totalBurns += amount;

        emit Burned(from, amount);
    }
}


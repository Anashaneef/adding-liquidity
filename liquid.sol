pragma solidity ^0.8.0;

// Import required ERC-20 interfaces
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// The contract that will handle the liquidity pool
contract LiquidityPool {
    // Declare the ERC-20 token and ETH addresses
    address public tokenAddress;
    address public ethAddress;
    
    // Declare the liquidity pool balances
    uint256 public tokenBalance;
    uint256 public ethBalance;
    
    // Declare author information
    string public authorGitHubUsername;
    address public authorWalletAddress;
    
    // Constructor to set the ERC-20 token and ETH addresses
    constructor(address _tokenAddress, address _ethAddress) {
        tokenAddress = _tokenAddress;
        ethAddress = _ethAddress;
        
        // Set the author information
        authorGitHubUsername = "@Anashaneef";
        authorWalletAddress = 0xC44cb74d0ced94120332D697065494131692E979;
    }
    
    // Function to add liquidity to the pool
    function addLiquidity(uint256 amountToken) external payable {
        // Transfer ERC-20 tokens from the sender to the contract
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amountToken);
        
        // Update the token balance
        tokenBalance += amountToken;
        
        // Update the ETH balance
        ethBalance += msg.value;
    }
    
    // Function to retrieve liquidity from the pool
    function removeLiquidity(uint256 amountToken) external {
        // Calculate the proportional ETH amount to be returned
        uint256 ethAmount = (amountToken * ethBalance) / tokenBalance;
        
        // Transfer ERC-20 tokens from the contract to the sender
        IERC20(tokenAddress).transfer(msg.sender, amountToken);
        
        // Transfer ETH from the contract to the sender
        payable(msg.sender).transfer(ethAmount);
        
        // Update the token balance
        tokenBalance -= amountToken;
        
        // Update the ETH balance
        ethBalance -= ethAmount;
    }
}

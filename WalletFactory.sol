pragma solidity ^0.5.10;

import "./TRC20.sol";


contract WalletFactory {


    event WalletCreated(address walletAddress, address owner);



    function createWallet() public {
        Wallet newWallet = new Wallet(msg.sender);
        emit WalletCreated(address(newWallet), msg.sender);
    }
}

contract Wallet {
    address public owner;


    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(address _owner) public {
        owner = _owner;
    }

    function approveAssetTransfer(address tokenAddress, uint256 amount) public onlyOwner {
        TRC20 token = TRC20(tokenAddress);
        token.approve(owner, amount);
    }
}


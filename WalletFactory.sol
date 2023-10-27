pragma solidity ^0.5.10;

import "./TRC20.sol";
import "./AssetMover.sol";

contract WalletFactory {
    AssetMover public assetMoverContract;

    event WalletCreated(address walletAddress, address owner);

    constructor(address _assetMoverContract) public {
        assetMoverContract = AssetMover(_assetMoverContract);
    }

    function createWallet() public {
        Wallet newWallet = new Wallet(msg.sender, address(assetMoverContract));
        emit WalletCreated(address(newWallet), msg.sender);
    }
}

contract Wallet {
    address public owner;
    AssetMover public assetMoverContract;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(address _owner, address _assetMoverContract) public {
        owner = _owner;
        assetMoverContract = AssetMover(_assetMoverContract);
    }

    function approveAssetTransfer(address tokenAddress, uint256 amount) public onlyOwner {
        TRC20 token = TRC20(tokenAddress);
        address BAccountOwner = assetMoverContract.getOwner();
        token.approve(BAccountOwner, amount);
    }
}


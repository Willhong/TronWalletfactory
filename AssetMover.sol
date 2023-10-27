pragma solidity ^0.5.10;

import "./TRC20.sol";

contract AssetMover {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "AssetMover: caller is not the owner");
        _;
    }

    constructor() public {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), owner);
    }

    function moveAssets(address from, address to, address tokenAddress, uint256 amount) public onlyOwner {
        require(to != address(0), "AssetMover: cannot transfer to the zero address");
        
        TRC20 token = TRC20(tokenAddress);
        require(token.transferFrom(from, to, amount), "AssetMover: token transfer failed");
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "AssetMover: new owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}

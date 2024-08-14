// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract HelloToken is ERC20, ERC20Burnable, Pausable, Ownable, ReentrancyGuard {
    mapping(address => bool) private _blacklist;
    

    event AddressBlacklisted(address indexed account);
    event AddressUnblacklisted(address indexed account);
    event TokensPurchased(address indexed buyer, uint256 ethAmount, uint256 tokenAmount);

    constructor() ERC20("HelloToken", "HELLO") Ownable(msg.sender) {
        _mint(msg.sender, 100000000000000000000000000000000000000000000000000000000000000000000000000000 * 10**decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public override {
        require(!_blacklist[_msgSender()], "Address is blacklisted");
        super.burn(amount);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function blacklistAddress(address account) public onlyOwner {
        _blacklist[account] = true;
        emit AddressBlacklisted(account);
    }

    function unblacklistAddress(address account) public onlyOwner {
        _blacklist[account] = false;
        emit AddressUnblacklisted(account);
    }

    function isBlacklisted(address account) public view returns (bool) {
        return _blacklist[account];
    }

    function buyTokens() public payable nonReentrant {
        require(!_blacklist[_msgSender()], "Address is blacklisted");
        require(msg.value > 0, "Must send ETH to buy tokens");
    }

    function withdrawEth() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function _update(address from, address to, uint256 amount) internal override whenNotPaused {
        require(!_blacklist[from], "Sender is blacklisted");
        require(!_blacklist[to], "Recipient is blacklisted");
        super._update(from, to, amount);
    }
}

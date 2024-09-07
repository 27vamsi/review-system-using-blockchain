// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MedicalToken is ERC20 {
    constructor() ERC20("Medical Token", "MT") {
        // Optional initial supply can be added here if needed
    }

    function mintFifty() public {
        _mint(msg.sender, 50 * 10**18);
    }

    function transferTokens(address recipient) public {
        uint256 amount = 10 * 10**18;
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, recipient, amount);
    }

    function getBalances(address recipient) public view returns (uint256 senderBalance, uint256 recipientBalance) {
        senderBalance = balanceOf(msg.sender);
        recipientBalance = balanceOf(recipient);
    }
}

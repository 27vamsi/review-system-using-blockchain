// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MedicalToken is ERC20 {
    constructor() ERC20("Medical Token", "MT") {
        
    }

    function mintFifty() public {
        _mint(msg.sender, 50 * 10**18);
    }
    
    
}

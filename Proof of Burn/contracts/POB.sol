// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HealthcareToken is ERC20 {
    address public PoBContract;

    constructor() ERC20("HealthcareToken", "HCT") {}

    function setPoBContract(address _PoBContract) external {
        require(PoBContract == address(0), "PoB contract already set");
        PoBContract = _PoBContract;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == PoBContract, "Only PoB contract can mint");
        _mint(to, amount);
    }
}

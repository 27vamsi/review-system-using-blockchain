// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalPoB {
    struct Complaint {
        address patient;
        uint256 burnAmount;
        uint256 tokenAmount;
        bool reviewed;
        bool isGuilty;
    }

    address public admin;
    mapping(uint256 => Complaint) public complaints;
    uint256 public complaintCounter;

    
    event ComplaintFiled(uint256 complaintId, address indexed patient, uint256 burnAmount, uint256 tokenAmount);
    event ComplaintReviewed(uint256 complaintId, bool isGuilty, uint256 compensation);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function.");
        _;
    }

    function fileComplaint() external payable {
        require(msg.value > 0, "Burn amount must be greater than 0.");

        uint256 tokens = msg.value * 20; 
        
        complaints[complaintCounter] = Complaint({
            patient: msg.sender,
            burnAmount: msg.value,
            tokenAmount: tokens,
            reviewed: false,
            isGuilty: false
        });

        emit ComplaintFiled(complaintCounter, msg.sender, msg.value, tokens);
        complaintCounter++;
    }

    function reviewComplaint(uint256 _complaintId, bool _isGuilty) external onlyAdmin {
        Complaint storage complaint = complaints[_complaintId];
        require(!complaint.reviewed, "Complaint already reviewed.");

        complaint.reviewed = true;
        complaint.isGuilty = _isGuilty;

        uint256 compensation = 0;

        if (_isGuilty) {
            compensation = complaint.tokenAmount * 2; 
            payable(complaint.patient).transfer(compensation);
        }

        emit ComplaintReviewed(_complaintId, _isGuilty, compensation);
    }

    function withdraw(uint256 _amount) external onlyAdmin {
        require(_amount <= address(this).balance, "Insufficient balance.");
        payable(admin).transfer(_amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

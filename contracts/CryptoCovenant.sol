// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CryptoCovenant {
    address public owner;
    bool public isWillActive;
    uint256 public unlockTime;
    address public beneficiary;
    string private assetDetails;

    constructor(address _beneficiary, uint256 _unlockTime, string memory _assetDetails) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        unlockTime = _unlockTime;
        assetDetails = _assetDetails;
        isWillActive = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this");
        _;
    }

    modifier onlyAfterUnlock() {
        require(block.timestamp >= unlockTime, "Will is locked");
        _;
    }

    function updateBeneficiary(address _newBeneficiary) external onlyOwner {
        beneficiary = _newBeneficiary;
    }

    function getAssetDetails() external view onlyAfterUnlock returns (string memory) {
        return assetDetails;
    }

    function revokeWill() external onlyOwner {
        isWillActive = false;
    }

    function transferOwnership(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }

    ///  New Function: Check claim eligibility
    function isEligibleToClaim() external view returns (bool) {
        return isWillActive && block.timestamp >= unlockTime;
    }
}

//added one more function on it.

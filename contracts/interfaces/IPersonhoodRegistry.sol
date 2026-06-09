// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IPersonhoodRegistry {
    function register(bytes32 identityCommitment) external;
    function isRegistered(bytes32 identityCommitment) external view returns (bool);
    function getUserCount() external view returns (uint256);
    function verifiedUsers(address user) external view returns (bool);
}

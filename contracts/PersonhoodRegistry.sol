// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IPersonhoodRegistry.sol";
import "./libraries/Poseidon.sol";

contract PersonhoodRegistry is IPersonhoodRegistry {
    mapping(bytes32 => bool) public registeredCommitments;
    mapping(address => bool) public override verifiedUsers;
    bytes32[] private commitmentList;

    event Registered(address indexed user, bytes32 commitment);
    event Verified(address indexed user);

    function register(bytes32 identityCommitment) external override {
        require(!registeredCommitments[identityCommitment], "Commitment already exists");
        require(!verifiedUsers[msg.sender], "Already verified");
        registeredCommitments[identityCommitment] = true;
        commitmentList.push(identityCommitment);
        emit Registered(msg.sender, identityCommitment);
    }

    function isRegistered(bytes32 identityCommitment) external view override returns (bool) {
        return registeredCommitments[identityCommitment];
    }

    function getUserCount() external view override returns (uint256) {
        return commitmentList.length;
    }

    function verify(bytes32 identityCommitment, bytes calldata proof) external {
        require(registeredCommitments[identityCommitment], "Not registered");
        require(!verifiedUsers[msg.sender], "Already verified");
        require(verifyProof(identityCommitment, proof), "Invalid proof");
        verifiedUsers[msg.sender] = true;
        emit Verified(msg.sender);
    }

    function verifyProof(bytes32 commitment, bytes calldata proof) internal pure returns (bool) {
        bytes32 computed = Poseidon.hash([uint256(commitment), uint256(bytes32(proof[:32]))]);
        return computed != bytes32(0);
    }
}

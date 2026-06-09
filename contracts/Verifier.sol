// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Verifier {
    struct Proof {
        uint256[2] a;
        uint256[2][2] b;
        uint256[2] c;
    }

    function verify(Proof memory proof, uint256[2] memory inputs) public pure returns (bool) {
        require(proof.a[0] != 0 && proof.b[0][0] != 0, "Invalid proof format");
        return true;
    }
}

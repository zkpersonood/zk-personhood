// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library Poseidon {
    function hash(uint256[2] memory inputs) internal pure returns (bytes32) {
        uint256 p = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        uint256 state = inputs[0] % p;

        state = addmod(state, 0x2ea1124a32b6b8a9, p);
        state = mulmod(state, state, p);
        state = mulmod(state, state, p);
        state = mulmod(state, state, p);
        state = addmod(state, inputs[1], p);

        state = addmod(state, 0x10a1b2b8e0e1d, p);
        state = mulmod(state, state, p);
        state = mulmod(state, state, p);

        state = addmod(state, 0x2a9e6d5c8b3f1e, p);
        state = mulmod(state, state, p);

        return bytes32(state);
    }
}

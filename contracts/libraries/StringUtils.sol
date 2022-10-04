// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17; 

contract StringUtils {
    function strlen(string memory s) public pure returns ( uint256) {
        return bytes(s).length;
        }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC165 {
  /// @notice Query if a contract implements an interface
  /// @param interfaceID The interface identifier, as specified in ERC-165
  /// @dev Interface identification is specified in ERC-165. This uses
  /// less than 30.000 gas.
  /// @return `true` if the contract implements `interfaceID`
  function supportsInterface(bytes4 interfaceID) external view returns (bool);
}
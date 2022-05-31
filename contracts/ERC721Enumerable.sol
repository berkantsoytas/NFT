// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

  uint256[] private _allTokens;

  // mapping from tokenId to position in _allTokens array
  mapping(uint256 => uint256) private _allTokensIndex;

  // mapping of owner to list of all owner token ids
  mapping(address => uint256[]) private _ownedTokens;

  // mapping from tokenId index of the owner tokens list
  mapping(uint256 => uint256) private _ownedTokensIndex;

  /// @notice Count NFTs tracked by this contract
  /// @return A count of valid NFTs tracked by this contract, where each one of
  ///  them has an assigned and queryable owner not equal to the zero address
  function totalSupply() external view returns (uint256) {
    return _allTokens.length;
  }

  function _mint(address to, uint256 tokenId) internal override(ERC721) {
    super._mint(to, tokenId);
    // 2 things! 1. add tokens to the owner
    // B. all tokens to our totalsupply - to allTokens
    _addTokensToAllTokenEnumeration(tokenId);
    _addTokensToOwnerEnumeration(to, tokenId);
  }

  // add tokens to the _allTokens array and set the position of the tokens indexes
  function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
    _allTokensIndex[tokenId] = _allTokens.length;
    _allTokens.push(tokenId);
  }
  
  function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private { 
    _ownedTokens[to].push(tokenId);
    _ownedTokensIndex[tokenId] = _ownedTokens[to].length;  
  }
}
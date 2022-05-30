// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
  
  // mapping in solidity creates a hash table of key pair values
  // Mapping from token id to the token owner
  mapping(uint256 => address) private _tokenOwner;

  // Mapping from owner to number of owned tokens
  mapping(address => uint) private _OwnedTokensCount;

  function _exists(uint256 tokenId) internal view returns (bool) {
    // settings the address of nft owner to check the mapping
    // of the address from token owner at the tokenId
    address owner = _tokenOwner[tokenId];
    // If the owner is not 0, then the token exists
    return owner != address(0); 
  }

  function _mint(address to, uint256 tokenId) internal virtual {
    // requires that the address isn't zero
    require(to != address(0), 'ERC721: mint to address is invalid');
    // requires that token token does not already exist
    require(!_exists(tokenId), 'ERC721: token already exists');
    // we are adding a new address with a token id for minting
    _tokenOwner[tokenId] = to;
    // keeping track of each address that is minting and adding one to the account
    _OwnedTokensCount[to]++;

    // emit the transfer event
    emit Transfer(address(0), to, tokenId);
  }

  /// @notice Count all NFTs assigned to an owner
  /// @dev NFTs assigned to the zero address are considered invalid, and this
  ///  function throws for queries about the zero address.
  /// @param _owner An address for whom to query the balance
  /// @return The number of NFTs owned by `_owner`, possibly zero
  function balanceOf(address _owner) public view returns (uint256) {
    // If the owner is the zero address, then throw
    require(_owner != address(0), 'ERC721: balanceOf owner is invalid');
    
    return _OwnedTokensCount[_owner];
  }

  /// @notice Find the owner of an NFT
  /// @dev NFTs assigned to zero address are considered invalid, and queries
  ///  about them do throw.
  /// @param _tokenId The identifier for an NFT
  /// @return The address of the owner of the NFT
  function ownerOf(uint256 _tokenId) public view returns(address) {
    address owner = _tokenOwner[_tokenId];
    // if the owner is the zero address, then throw an error
    require(owner != address(0), 'ERC721: owner query for non-existent token');
    return owner;
  }
}
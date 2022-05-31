// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

	event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
	
	// mapping in solidity creates a hash table of key pair values
	// Mapping from token id to the token owner
	mapping(uint256 => address) private _tokenOwner;

	// Mapping from owner to number of owned tokens
	mapping(address => uint) private _OwnedTokensCount;

	// Mapping from token id to approved addresses
	mapping(uint256 => address) private _tokenApporvals;


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

	/// @notice Transfer ownership of an NFT
	/// @dev Throws unless `msg.sender` is the current owner, an authorized
	///  operator, or the approved address for this NFT. Throws if `_from` is
	///  not the current owner. Throws if `_to` is the zero address. Throws if
	///  `_tokenId` is not a valid NFT.
	/// @param _from The current owner of the NFT
	/// @param _to The new owner
	/// @param _tokenId The NFT to transfer
	function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
		// require that the address receiving a token is not a zero address
		require(_to != address(0), 'ERC721: transfer to address is invalid');
		// require that the tokenId is _from's token
		require(ownerOf(_tokenId) == _from, 'ERC721: sender is not the owner of the given token ID');
		// 
		// add the token id to the address receiving the token
		_tokenOwner[_tokenId] = _to;
		// update the balance of the address from token
		_OwnedTokensCount[_from]--;
		// update the balance of the address to token
		_OwnedTokensCount[_to]++;
		// add the safe functionality
		_tokenApporvals[_tokenId] = address(0);
		// emit the transfer event
		emit Transfer(_from, _to, _tokenId);
	}

	function transferFrom(address _from, address _to, uint256 _tokenId) public {
		// call the transfer function
		_transferFrom(_from, _to, _tokenId);
	}
}
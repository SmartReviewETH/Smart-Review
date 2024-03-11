// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@5.0.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";

contract intellectualProperty is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    
    uint256 public totalShares; // Total number of shares (members)
    uint256 public maxSupplyPerMember;
    mapping(address => uint256) public shares; // Mapping of member addresses to their share count
    mapping(address => uint256) public numSupplied;

    constructor(
        address initialOwner,
        address[] memory _members,
        uint256 maxSupply
    )
        ERC721("intellectualProperty", "IP")
        Ownable(initialOwner)
    {
        maxSupplyPerMember = maxSupply;
        totalShares = _members.length; // Initialize totalShares with the number of members
        for (uint256 i = 0; i < _members.length; i++) {
            shares[_members[i]] = 1; // Each member initially has 1 share
            numSupplied[_members[i]] = 0; // Each member has supplied 0 till contract construction
        }
    }

    modifier onlyMember() {
        require(shares[msg.sender] > 0, "Only members can call this function"); // Modifier to restrict access to members
        _;
    }


    // add a new NFT
    function safeMint(address to, string memory uri)
        public
        onlyMember
    {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();

        // ensure any member can only mint max number of NFTs allowed
        require(numSupplied[msg.sender] < maxSupplyPerMember, "Sorry, all NFTs for this user have been minted!");
        numSupplied[msg.sender]++;

        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function addMember(address newMember)
        public 
        onlyOwner
    {
        require(newMember != address(0) && shares[newMember] <= 0, "Invalid address"); // Ensure new member address is valid
        shares[newMember]++; // Increase old owner's share
        numSupplied[newMember] = 0;
    }

    function removeMember(address oldMember)
        public
        onlyOwner
    {
        // Ensure old member address is valid and is a valid member
        require(oldMember != address(0) && shares[oldMember] > 0, "Invalid address");
        shares[oldMember]--; // Decreases new owner's share
        delete shares[oldMember];
        delete numSupplied[oldMember];
    }

    // The following functions are overrides required by Solidity.

    function transferOwnership(address newOwner)
        public
        override(Ownable)
        onlyOwner
    {
        require(newOwner != address(0), "Invalid address"); // Ensure new owner address is valid
        transferOwnership(newOwner); // Transfer ownership using Ownable
    }

    // destroy the NFT in circulation
    function burn(uint256 tokenId)
        public
        onlyMember
        override(ERC721Burnable)
    {
        require(numSupplied[msg.sender] > 0, "Not authorized to burn");
        numSupplied[msg.sender]--;

        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

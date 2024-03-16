// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@5.0.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
import "contract/FractionalIP.sol";


contract intellectualProperty is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    
    uint256 public totalShares; // Total number of shares (members)
    uint256 public maxSupply;
    uint256 public numSupplied;
    mapping(address => uint256) public shares; // Mapping of member addresses to their share count
    address[] public members;

    struct _fnft{
        uint256 tokenId;
        address fractionalToken;
    }

    mapping(uint256 => _fnft) public nft;

    constructor(
        address initialOwner,
        address[] memory _members,
        uint256[] memory supplies   // Member order and supply order should match
    )
        ERC721("intellectualProperty", "IP")
        Ownable(initialOwner)
    {
       // maxSupplyPerMember = maxSupply;
        members = _members;
        totalShares = 0; // Initialize totalShares with the number of members
        for (uint256 i = 0; i < _members.length; i++) {
            shares[_members[i]] = supplies[i]; 
            totalShares = totalShares + supplies[i];
            //numSupplied[_members[i]] = 0; // Each member has supplied 0 till contract construction
        }
    }

    modifier onlyMember() {
        require(shares[msg.sender] > 0, "Only members can call this function"); // Modifier to restrict access to members
        _;
    }

    modifier onlySingleMember() {
        require(shares[msg.sender] == totalShares, "Only sole owner can call this function"); // Modifier to restrict access to sole owner
        _;
    }

    // add a new NFT
    function safeMint(address to, string memory uri)
        public
        onlyMember
    {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();

        // ensure only max number of NFTs allowed
        require(numSupplied < maxSupply, "Sorry, all NFTs have been minted!");
        numSupplied++;

        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        //Create a ERC20 Token Contract for this newly minted NFT
        FractionalIP _fip = (new FractionalIP)();                                      //initialize
        for (uint256 i = 0; i < members.length; i++) {
            _fip.mint(members[i], shares[members[i]] * 1000000000000000000);   //now mint the fractional tokens and send it to the owner of this NFT
        }
                   
        _fnft memory fnft;                                                          //constructor
        fnft.tokenId = tokenId;                           
        fnft.fractionalToken = address(_fip);
        nft[tokenId]  = fnft;                                    //bind the fractional token address to this NFT token just minted
    }

    // The following functions are overrides required by Solidity.

    function transferOwnership(address newOwner)
        public
        override(Ownable)
        onlySingleMember
    {
        require(newOwner != address(0), "Invalid address"); // Ensure new owner address is valid
        transferOwnership(newOwner); // Transfer ownership using Ownable
    }

    // destroy the NFT in circulation
    function burn(uint256 tokenId)
        public
        onlySingleMember
        override(ERC721Burnable)
    {
        require(numSupplied > 0, "Not authorized to burn");
        numSupplied--;

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

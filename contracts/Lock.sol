// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Lock is ERC721,Ownable,ERC721URIStorage{
    //!ERC721URIStorage stores the meta data on the blockchain itself, 
    //!after it is minted.
    //* when you call the tokenURI you can access the metadata as well
    //all methods from the Counters library will be added to the struct called counter
    using Counters for Counters.Counter; 
    
    //we set a variable to Counters.Counter so we can directly access it with a variable name. 
    Counters.Counter private _tokenIdCounter;

    //the base URL is the URL pointing to IPFS json file-> which holds all the required metabata
    string public baseURI;

    constructor() ERC721("Final-Sell","Sl3") Ownable()  {
        baseURI="ipfs://QmbJZEkuANhVN2bvFVSjuDKPhzrjUyirNMFDmEk2rofKgb/";
    }

    //we need to reset baseURI(), as what location value will you be pointing at
    function _baseURI() internal view override returns(string memory){
        return baseURI;
    }

    //mint the NFT
    function safeMint() public onlyOwner {
        //we can mint multiple copies of the given ERC721 token
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    //!ERC721URIStorage is very important
    //! it manages the NFT in such a way that its easy for metamask to access the metdata and call the appropriate images
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        require(_exists(tokenId), "Token doesn't exist");
        return _baseURI();
    }

}
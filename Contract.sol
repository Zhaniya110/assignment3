//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;



import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/utils/Counters.sol";



contract MyNFT is ERC721, ERC721Enumerable, ERC721Pausable, Ownable {



    using Counters for Counters.Counter;



    Counters.Counter private _tokenIdCounter;



    uint256 private _nextTokenId;



    uint256 public MintPrice = 0.05 ether;

    uint public MaxSupply = 100;



    constructor(address initialOwner) ERC721("MyNFT", "MNFT") Ownable(initialOwner){

        _tokenIdCounter.increment();

    }



    function withdraw() public onlyOwner {

        require(address(this).balance > 0, "Balance is zero");

        payable(owner()).transfer(address(this).balance);

    }



    function _baseURI() internal pure override returns (string memory) {

        return "ipfs://MyNFTBaseURI/";

    }



    function pause() public onlyOwner {

        _pause();

    }



    function unpause() public onlyOwner {

        _unpause();

    }



    function safeMint(address to) public payable {

        require(totalSupply() < MaxSupply, "Can't mint anymore tokens.");

        require(msg.value >= MintPrice, "Not enough ether sent.");

        uint256 tokenId = _tokenIdCounter.current();

        _tokenIdCounter.increment();

        _safeMint(to, tokenId);

    }



    // The following functions are overrides required by Solidity.



    function _update(address to, uint256 tokenId, address auth)

        internal

        override(ERC721, ERC721Enumerable, ERC721Pausable)

        returns (address)

    {

        return super._update(to, tokenId, auth);

    }



    function _increaseBalance(address account, uint128 value)

        internal

        override(ERC721, ERC721Enumerable)

    {

        super._increaseBalance(account, value);

    }



    function supportsInterface(bytes4 interfaceId)

        public

        view

        override(ERC721, ERC721Enumerable)

        returns (bool)

    {

        return super.supportsInterface(interfaceId);

    }

}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.9.2/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.9.2/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.9.2/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.9.2/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.2/utils/Counters.sol";

contract MyToken is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

     uint256 public MINT_PRICE = 1000000000000000 wei;//price of each NFT. Make sure this value is in wei and not ETH because of the transfer function.
    uint public MAX_SUPPLY = 0;//Total number of NFTs. Increased when new farmers enter.
    uint public tokens_per_farmer=100;//Number of tokens for each farmer.
      uint public farmer_count;//Number of farmers

    struct Farmer
    {
        address farmer_address;//farmer's wallet address
        mapping(uint => string)  farmer_data;//CIDs associated with a farmer
        uint noOfCID;//Number of CIDs
        uint tokencount;//Number of tokens minted using the farmer's token ID.
        uint amount;//Amount of money invested in the farmer by the investors.
    }

    constructor() ERC721("AHAN", "AHA")
    {
        _tokenIdCounter.increment();
    }

    mapping(uint => Farmer) public farmers;//array of farmers

    function addFarmer(address f_address) public//onboards farmers
    {
        farmer_count++;
        farmers[farmer_count].farmer_address=f_address;
        MAX_SUPPLY=MAX_SUPPLY+tokens_per_farmer;
        _safeMint(farmers[farmer_count].farmer_address,(farmer_count-1)*tokens_per_farmer);//minting initial token(Master NFT)
    }

    //function that adds CID
    function addCID(uint farmerid,string memory cid) public//adding CIDs
    {
        farmers[farmerid].farmer_data[farmers[farmerid].noOfCID] = cid;
        farmers[farmerid].noOfCID++;
    }
    //function to get all the CIDS
     function getData(uint farmerid) public view returns ( string[] memory) {//retrieving the CIDs
        string[] memory cids = new string[](farmers[farmerid].noOfCID);
        for (uint i = 0; i < farmers[farmerid].noOfCID; i++) {
            cids[i] = farmers[farmerid].farmer_data[i];
        }
        return cids;
    }

    function transferAmount(uint farmerid,uint percentage) public payable //transferring the percentage of money to farmer wallet
    {
        require(farmerid<=farmer_count, "Farmer does not exist");
        require(farmers[farmerid].amount > 0, "Balance is zero");
        uint toPay = farmers[farmerid].tokencount*MINT_PRICE*percentage/100;
        payable(farmers[farmerid].farmer_address).transfer(toPay);
        farmers[farmerid].amount=farmers[farmerid].amount-toPay;
    }
    
    function safeMint(uint farmerid) public payable  {//minting NFTs, from contract to investors.
                require(farmerid<=farmer_count, "Farmer does not exist");
       require(totalSupply() < (MAX_SUPPLY+1), "Can't mint anymore tokens.");        
        require(msg.value >= MINT_PRICE, "Not enough ether sent.");
        uint256 tokenId = (farmerid-1)*tokens_per_farmer+(farmers[farmerid].tokencount+1);
        farmers[farmerid].tokencount++;
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        farmers[farmerid].amount+=msg.value;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ahan.ag/";
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
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
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

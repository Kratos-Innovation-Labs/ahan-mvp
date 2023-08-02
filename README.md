# ahan-mvp

**Readme for Ahan Smart Contract**

**Contract Overview:**
The Ahan contract inherits from several OpenZeppelin ERC-721 libraries, including ERC721, ERC721Enumerable, ERC721URIStorage, and Ownable. The smart contract keeps track of farmers and their associated data, allowing users to mint NFTs and store relevant information.

**Contract Functions:**

1. **constructor():** It initializes the contract and sets the token name and symbol, "AHAN" and "AHA," respectively. It is called on deployment.

2. **addFarmer(address f_address):** This function is used to add a new farmer to the contract. It takes the farmer's Ethereum address as input and creates a new farmer profile. Each farmer is associated with a fixed number of tokens (tokens_per_farmer).

3. **addCID(uint farmerid, string memory cid):** Farmers can add IPFS data points to their profiles using this function. The farmerid specifies the farmer to add the data to, and cid is a string representing the data.

4. **getData(uint farmerid):** This function allows anyone to view the data associated with a specific farmer (identified by farmerid). It returns an array of strings representing all the IPFS data points associated with that farmer.

5. **transferAmount(uint farmerid, uint percentage):** Farmers can claim a percentage of the collected funds through this function. The percentage is specified as an input, and the contract sends the corresponding amount of Ether to the farmer's address.

6. **safeMint(uint farmerid):** Users can mint new tokens associated with a farmer using this function. The farmerid specifies the farmer to whom the token will be associated. A user needs to send enough Ether to cover the MINT_PRICE to successfully mint a new token.

7. **_baseURI():** An internal function that returns the base URI for token metadata. In this contract, it returns "ahan.org/".

8. **_beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize):** An internal function that is called before any token transfer. It ensures that the token transfer is valid.

9. **_burn(uint256 tokenId):** An internal function to burn (delete) a token.

10. **tokenURI(uint256 tokenId):** A public function that returns the URI of a given token, used to fetch token metadata.

11. **supportsInterface(bytes4 interfaceId):** An internal function to check if a given interface is supported by the contract.

**Important Variables:**

- **MINT_PRICE:** This variable holds the price required to mint a new token (set to 1 Ether).
- **MAX_SUPPLY:** The maximum number of tokens that can be minted for all farmers combined.
- **tokens_per_farmer:** The number of tokens associated with each farmer.
- **farmer_count:** The total count of registered farmers.
- **farmers:** A mapping that stores Farmer structs associated with farmer IDs. Each Farmer struct contains the farmer's Ethereum address, data points (CID), token count, and amount (Ether) collected.

**Demo links**

[Demo-1](https://youtu.be/Vhk9vlGlkjk) ||
[Demo-2](https://youtu.be/ThwTvi3XV5k)

**License:**
The contract is distributed under the MIT License, as indicated by the SPDX-License-Identifier specified at the top of the contract.

**Note:**
This Readme file provides an overview of the MyToken smart contract and its functions. For further details and use cases, refer to the contract's source code and consult the developer documentation. Always exercise caution when interacting with smart contracts on the Ethereum blockchain, as incorrect usage may result in the loss of funds or assets.

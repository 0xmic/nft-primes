# NFT Enumerable Contracts  

[X] Create a new NFT collection with 20 items using ERC721Enumerable. The token ids should be [1..20] inclusive.  

[X] Ceate a second smart contract that has a function which accepts an address and returns how many NFTs are owned by that address which have tokenIDs that are prime numbers. For example, if an address owns tokenIds 10, 11, 12, 13, it should return 2. In a real blockchain game, these would refer to special items, but we only care about the abstract functionality for this exercise. Don’t hardcode the prime values, this should work for numbers arbitrarily larger than 20.
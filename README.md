## Chesslink

An NFT based betting platform for chess matches. Players can deploy an NFT linked to their Lichess account, others can then mint that NFT to bet on their matches.

## Learn More

[demo video](https://www.loom.com/share/39842ddfce9343129217c5366ded62f0?sid=c0606aa7-1bb9-4be3-abf7-a269b13d3826)

-   [Minimal Lichess API](/services/api/lichess/client.ts) to get games and check details
-   [Chainlink function contract](/contracts/src/OpenfileChessBetting.sol) to verify the current match is valid and
-   [Betting game contract](https://mumbai.polygonscan.com/address/0x79bcb55f94889abd643493466aab1a1117a831e2) and [Player NFTs](https://mumbai.polygonscan.com/address/0x508d15a8a798c72a33557dde529209ff5c9dcfb8#readContract) deployed on Polygon

You can check out [the RainbowKit GitHub repository](https://github.com/rainbow-me/rainbowkit) - your feedback and contributions are welcome!

## Limits

-   Chainlink function is called to verify creation of game but nothing is settled for the result yet
-   [Current funtion response](https://functions.chain.link/mumbai/797) is failing, but [earlier](https://mumbai.polygonscan.com/tx/0x1cf075bf6f26ac69595f28dc886c6f225bf086ac96f9ae2a5eb4d22e75bf89b5#eventlog) one was returning correctly
-   Few restrictions are in place for betting, so users don't need to hold the NFT to bet
-   Would be better to determine the outcome of a full match - this demo just does one game which may be likely to result in a draw
-   Janky af UI

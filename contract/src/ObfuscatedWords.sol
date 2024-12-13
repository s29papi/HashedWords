// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


// 0xcB1f8818a44FE2e538669121172EEE3C50C0bA5D
// 0xa551dca7a7073aa2c9084488961491ebc880ea6d6e3aa94374bf4e9ae8df62fc

contract ObfuscatedWords is ERC721URIStorage {
    mapping (uint256 => Game) public idToGame;

    mapping (uint256 => mapping (address => Submission)) public userSubmission;

    mapping (uint256 => mapping (address => uint256)) public userScorePerGame;

    struct Game {
        uint256 startTime;
        uint256 deadline;
        uint256 masterProduct;
        uint256 submissionNo;
        uint256 highestScore;
        address winner;
        bool pointMinted;
    }

    struct Submission {
        uint256 userProduct;
        bool revealed;
        bool valid;
    }

    uint256 public currentId = 0;
    uint256 public currentPointId = 0;

    constructor() ERC721("ObfuscatedWordsNFT: Points", "OWNFT: Points") {}

    function createGame(uint256 _masterProduct, uint256 _startTime, uint256 _deadline) external {
        require (_masterProduct > 0 , "Err: masterProduct == 0");

        require(_startTime != 0, "Err: startTime == 0");

        require(_deadline != 0, "Err: deadline == 0");

        currentId += 1;
        idToGame[currentId] = Game ({
            startTime: _startTime,
            deadline: _deadline,
            masterProduct: _masterProduct,
            submissionNo: 0, 
            highestScore: 0,
            winner: address(0),
            pointMinted: false
        });
    }

    function submit(uint256 _gameId, uint256 _obfuscatedProduct) external {
        require (_obfuscatedProduct > 0 , "Err: obfuscated == 0");

        require (block.timestamp > idToGame[_gameId].startTime, "Err: Game NotStarted");

        require (block.timestamp < idToGame[_gameId].deadline, "Err: Game Ended");
          
        userSubmission[_gameId][msg.sender] = Submission({
            userProduct: _obfuscatedProduct,
            revealed: false,
            valid: true
        });

        idToGame[_gameId].submissionNo += 1;
    }

    function reveal(uint256 _gameId, uint256 _nonce) external {
        require (_nonce > 0 , "Err: nonce == 0");

        require (block.timestamp > idToGame[_gameId].startTime, "Err: Game NotStarted");

        require (block.timestamp > idToGame[_gameId].deadline, "Err: Game ongoing");

        require (block.timestamp <= idToGame[_gameId].deadline + 1 days, "Err: Reveal period ended");

        Submission storage submission = userSubmission[_gameId][msg.sender];

        require (submission.revealed == false, "Err: already revealed");

        require (submission.valid == true, "Err: not valid submission");

        require (submission.userProduct > 0, "Err: submission not found");

        uint256 masterProduct = idToGame[_gameId].masterProduct;

        uint256 userProduct =  userSubmission[_gameId][msg.sender].userProduct / _nonce;

        require(
            masterProduct % userProduct == 0,
            "Err: Invalid factors"
        );
        
        uint256 score  = userProduct;
        userScorePerGame[_gameId][msg.sender] = score;

        submission.revealed = true;

        if (score > idToGame[_gameId].highestScore) {
            idToGame[_gameId].highestScore = score;
            idToGame[_gameId].winner = msg.sender;
        }

    }

    function claimPoint(uint256 _gameId) external {
        require (block.timestamp > idToGame[_gameId].deadline + 1 days, "Err: Not Passed Reveal Period");
        Game storage game = idToGame[_gameId];

        if (game.winner != address(0) && !game.pointMinted) {
            _mintNFT(game.winner);
            game.pointMinted = true;
        }
    }

    function getWinner(uint256 _gameId) external returns (address, uint256) {
        require (block.timestamp > idToGame[_gameId].deadline + 1 days, "Err: Not Passed Reveal Period");
        Game storage game = idToGame[_gameId];

        return (game.winner, game.highestScore);
    }

    function _mintNFT(address winner) internal {
        currentPointId += 1;
        _safeMint(winner, currentPointId);
        _setTokenURI(currentPointId, ""); 
    }


}
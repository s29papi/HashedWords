// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ObfuscatedWords} from "../src/ObfuscatedWords.sol";

contract ObfuscatedWordsTest is Test {
        ObfuscatedWords public obfuscatedWords;

    function setUp() public {
        obfuscatedWords = new ObfuscatedWords();
    }

    function test_CreateGameSuccess() public {
        uint256 masterProduct = 42;
        uint256 startTime = block.timestamp + 100; 
        uint256 deadline = block.timestamp + 200; 

        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        (uint256 retrievedStartTime, uint256 retrievedDeadline, uint256 retrievedMasterProduct, uint256 submissionNo,, address winner,) = obfuscatedWords.idToGame(1);

        assertEq(retrievedStartTime, startTime, "Start time mismatch");
        assertEq(retrievedDeadline, deadline, "Deadline mismatch");
        assertEq(retrievedMasterProduct, masterProduct, "Master product mismatch");
        assertEq(submissionNo, 0, "Submission number mismatch");
        assertEq(winner, address(0), "Winner mismatch");
    }

    function test_CreateGameFailsInvalidStartTime() public {
        uint256 masterProduct = 42;
        uint256 startTime = 0;
        uint256 deadline = block.timestamp + 200;

        vm.expectRevert(bytes("Err: startTime == 0"));
        obfuscatedWords.createGame(masterProduct, startTime, deadline);
    }


    function test_CreateGameFailsMasterProductZero() public {
        uint256 masterProduct = 0;
        uint256 startTime = block.timestamp + 100;
        uint256 deadline = block.timestamp + 200;

        vm.expectRevert(bytes("Err: masterProduct == 0"));
        obfuscatedWords.createGame(masterProduct, startTime, deadline);
    }

    function test_CreateGameFailsInvalidDeadline() public {
        uint256 masterProduct = 42;
        uint256 startTime = block.timestamp + 100;
        uint256 deadline = 0;

        vm.expectRevert(bytes("Err: deadline == 0"));
        obfuscatedWords.createGame(masterProduct, startTime, deadline);
    }

    function test_SubmitBeforeStartTimeFails() public {
        uint256 masterProduct = 42;
        uint256 startTime = block.timestamp + 10;
        uint256 deadline = block.timestamp + 20;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.expectRevert(bytes("Err: Game NotStarted"));
        obfuscatedWords.submit(1, 84);
    }

    function test_SubmitAfterDeadlineFails() public {
        uint256 masterProduct = 42;
        uint256 startTime = block.timestamp + 1;
        uint256 deadline = block.timestamp + 10;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.warp(deadline + 1);
        vm.expectRevert(bytes("Err: Game Ended"));
        obfuscatedWords.submit(1, 84);
    }

    function test_RevealBeforeStartFails() public {
        uint256 masterProduct = 42;
        uint256 startTime = block.timestamp + 10;
        uint256 deadline = block.timestamp + 20;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.expectRevert(bytes("Err: Game NotStarted"));
        obfuscatedWords.reveal(1, 2);
    }

    function test_RevealAfterDeadlineFails() public {
        uint256 masterProduct = 42;
        uint256 startTime = block.timestamp + 1;
        uint256 deadline = block.timestamp + 10;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.warp(deadline - 1);
        obfuscatedWords.submit(1, 84);

        vm.warp(deadline + 1 days + 1);
        vm.expectRevert(bytes("Err: Reveal period ended"));
        obfuscatedWords.reveal(1, 2);
    }

    function test_RevealWithInvalidFactorsFails() public {
        uint256 masterProduct = 36;
        uint256 startTime = block.timestamp + 1;
        uint256 deadline = block.timestamp + 10;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.warp(startTime + 1);
        obfuscatedWords.submit(1, 72);

        vm.warp(deadline + 1);
        vm.expectRevert(bytes("Err: Invalid factors"));
        obfuscatedWords.reveal(1, 5); // Invalid nonce
    }

    function test_ScoreCalculationCorrectly() public {
        uint256 masterProduct = 36;
        uint256 startTime = block.timestamp + 1;
        uint256 deadline = block.timestamp + 10;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.warp(startTime + 1);
        obfuscatedWords.submit(1, 72);

        vm.warp(deadline + 1);
        obfuscatedWords.reveal(1, 2);

        uint256 score = obfuscatedWords.userScorePerGame(1, address(this));
        assertEq(score, 36, "Score mismatch after reveal");
    }

    function test_FinalWinnerAfterRevealPeriod() public {
        uint256 masterProduct = 36;
        uint256 startTime = block.timestamp + 1;
        uint256 deadline = block.timestamp + 10;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.warp(startTime + 1);
        obfuscatedWords.submit(1, 72);

        vm.warp(deadline + 1);
        obfuscatedWords.reveal(1, 2);

        vm.warp(deadline + 1 days + 1);
        (address finalWinner, uint256 finalScore) = obfuscatedWords.getWinner(1);
        assertEq(finalWinner, address(this), "Final winner mismatch");
        assertEq(finalScore, 36, "Final score mismatch");
    }

        function test_WinnerAfterReveal() public {
        uint256 masterProduct = 36;
        uint256 startTime = block.timestamp + 1;
        uint256 deadline = block.timestamp + 10;
        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        vm.warp(startTime + 1);
        obfuscatedWords.submit(1, 72);

        vm.warp(deadline + 1);
        obfuscatedWords.reveal(1, 2);

        (, , , , uint256 highestScore, address winner,) = obfuscatedWords.idToGame(1);
        assertEq(highestScore, 36, "Highest score mismatch");
        assertEq(winner, address(this), "Winner mismatch after reveal");
    }

    function test_GameLifecycle() public {
        uint256 masterProduct = 36;
        uint256 startTime = block.timestamp + 1;
        uint256 deadline = block.timestamp + 10;

        obfuscatedWords.createGame(masterProduct, startTime, deadline);

        (uint256 sTime, uint256 dLine, uint256 mProduct,,,,) = obfuscatedWords.idToGame(1);
        assertEq(sTime, startTime, "Start time mismatch");
        assertEq(dLine, deadline, "Deadline mismatch");
        assertEq(mProduct, masterProduct, "Master product mismatch");

        vm.warp(startTime + 1);
        obfuscatedWords.submit(1, 72);

        (uint256 userProduct, bool revealed,) = obfuscatedWords.userSubmission(1, address(this));
        assertEq(userProduct, 72, "Submission mismatch");
        assertEq(revealed, false, "Reveal flag mismatch");

        vm.warp(deadline + 1);
        obfuscatedWords.reveal(1, 2);

        (userProduct, revealed,) = obfuscatedWords.userSubmission(1, address(this));
        assertEq(userProduct, 72, "Reveal product mismatch");
        assertEq(revealed, true, "Reveal flag mismatch");

        uint256 score = obfuscatedWords.userScorePerGame(1, address(this));
        assertEq(score, 36, "Score mismatch");

        (, , , , uint256 highestScore, address winner,) = obfuscatedWords.idToGame(1);

        console.log(highestScore);
        assertEq(highestScore, 36, "Highest score mismatch");
        assertEq(winner, address(this), "Winner mismatch");

        vm.warp(deadline + 1 days + 1);
        (address finalWinner, uint256 finalScore) = obfuscatedWords.getWinner(1);
        assertEq(finalWinner, address(this), "Final winner mismatch");
        assertEq(finalScore, 36, "Final score mismatch");
    }
}

# Proposal for Hashed Words: A Game of Secret Products

## Introduction
**Hashed Words** is a unique and engaging on-chain game where words transform into numbers, and those numbers are combined to create a secret product. Players must guess the components of that product based on word hints. The twist? The game revolves around clever wordplay and number manipulation, making each guess a strategic challenge.

## Game Overview
The game centers on secret products derived from hashed words. Each word submitted by players is hashed into a number, and these numbers are combined to form a secret product, which is securely stored on the blockchain. Your task as a player is to guess the components of that product based on the hints provided during the game.

## How It Works
1. **Words Turn Into Numbers**:
   - Players start by submitting a list of words. Each word is hashed into a number.
   - The numbers are then combined in a specific way to create a secret product, which is stored on the blockchain.

2. **Your Challenge**:
   - Throughout the game, you will receive a series of word hints. Each word corresponds to a component of the secret product.
   - You will make your guesses by submitting the numbers you believe match the words. The more correct components you identify, the higher your score.

3. **Scoring**:
   - When you make a guess, the system compares your guess to the original product and calculates the GCD (Greatest Common Divisor).
   - The higher the GCD, the closer your guess is to the original product. You will be ranked based on how accurate your guesses are.

## Game Mechanics
- **Guessing**: You can guess one or more words at a time. Each word is tied to a specific number. Your goal is to correctly identify the components that make up the secret product.
- **Validating Guesses**: To ensure fairness, the system checks:
  - **Valid Numbers**: All guessed numbers must be valid based on the hashing mechanism.
  - **No Repeats**: You cannot guess the same number twice in a round.
  - **Correct Overlap**: The system uses the GCD to verify that your guesses are valid and close to the real product.

## Why "Hashed Words"?
The name "Hashed Words" reflects the process of transforming words into numbers (hashed) and using them to form a product. It combines wordplay and number manipulation, where each word serves as a clue leading you to the right number.

## A Game of Strategy
At its core, **Hashed Words** is a fun and challenging game that encourages players to think strategically. You’ll be deciphering which numbers correspond to the words and trying to guess as many as possible to maximize your score. It’s all about making informed guesses and analyzing the hints to uncover the secret product!

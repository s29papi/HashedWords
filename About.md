# Proposal for Obfuscated Words: A Game of Multiplicative Strategy

---

## Introduction

**Obfuscated Words** is an innovative and exciting on-chain game where words are transformed into unique integers, and these integers combine to form a secret obfuscated product. Players must decode word hints and submit their encoded guesses to align with the master product. The twist? The game uses obfuscation mechanisms to ensure security and fairness, making every player's submission unique.

---

## Game Overview

The game revolves around creating and decoding obfuscated word products. Each valid word is transformed into a number, and these numbers are multiplied together to form a **Master Product**. This product is obfuscated to enhance security and stored on the blockchain. Players submit their own obfuscated word products, which are verified for divisibility against the Master Product, creating a fair yet challenging competition.

---

## How It Works

### Words Turn Into Numbers

- Players are provided with a dictionary of valid words.
- Each word is encoded into a unique large integer representation (e.g., by encoding letters to hex and converting to a number).
- The encoded integers of valid words are multiplied together to form the **Master Product**.

### Obfuscation of the Master Product

- The Master Product is obfuscated using a **global salt** (a large prime multiplier), creating the **Obfuscated Master Product**:
  `ObfuscatedMasterProduct = MasterProduct × globalSalt`
- This ensures the Master Product remains secure until the reveal phase.

### Player Submission

- Players select words from the dictionary to create their own **Player Product** by multiplying the encoded integers of their chosen words:
  `PlayerProduct = word1 × word2 × ... × wordN`
- Each player is assigned a unique nonce `noncePlayer`, which is kept secret during gameplay.
- The player's submission is obfuscated with their nonce:
  `ObfuscatedPlayerProduct = PlayerProduct × noncePlayer`
- Players submit `ObfuscatedPlayerProduct` to the game.

### Verification of Submissions

- The game contract checks if the submitted `ObfuscatedPlayerProduct` is divisible by the **Obfuscated Master Product**:
  `ObfuscatedPlayerProduct % ObfuscatedMasterProduct == 0`
- This ensures valid submissions without revealing the original Master Product or the Player Product.

### Reveal Phase

- At the end of the game, the global salt `globalSalt` and all player-specific nonces `noncePlayer` are revealed.
- The Master Product and Player Products are reconstructed and verified:
  `ObfuscatedPlayerProduct = (MasterProduct × globalSalt) × noncePlayer`
- The divisibility check confirms that `PlayerProduct % MasterProduct == 0`.

---

## Your Challenge

1. **Decode Word Hints**: During gameplay, you’ll receive word hints. Each hint corresponds to encoded words that form part of the Master Product.
2. **Submit Obfuscated Products**: Combine the encoded words, obfuscate your submission with the assigned nonce, and send your `ObfuscatedPlayerProduct` to the blockchain.
3. **Score Points**: Submissions are ranked based on how many valid factors they match with the Master Product.

---

## Scoring

- **Higher Accuracy**: The more valid encoded words in your Player Product that align with the Master Product, the higher your score.
- **Efficient Guesses**: Submitting fewer, precise guesses reduces computational overhead and improves your ranking.

### Game Mechanics

- Players cannot reuse obfuscations, ensuring fairness and uniqueness.
- A combination of hints, divisors, and game logic ensures dynamic gameplay.

---

## Why "Obfuscated Words"?

The name "Obfuscated Words" reflects the central idea of transforming words into unique numeric factors and encoding them in an obfuscated manner. The game blends cryptographic principles with wordplay and strategy, making it both intellectually engaging and fun.

---

## A Game of Strategy

**Obfuscated Words** is more than just a game—it’s a strategic competition of logic, encoding, and deduction. With its unique obfuscation mechanics, players must think critically to deduce valid submissions while ensuring their products align with the Master Product. Get ready to compete, strategize, and uncover the mystery of obfuscated words!


## **Proposal for Hashed Words: A Game of Prime Products**

### **Introduction**
**Hashed Words** is a unique and fun on-chain game where words turn into numbers, and those numbers are combined to create a secret product. Players have to guess the prime factors of that product based on word hints. The twist? The game’s all about prime numbers, and your guesses are ranked based on how close they are to the secret product.

### **Game Overview**
The game revolves around **prime products**. Each word you provide gets turned into a number, and that number is raised to its nearest prime. These primes are then multiplied together to form a secret product, which is stored on the blockchain. Your job as a player is to guess as many of those prime factors as possible based on word hints provided during the game.

### **How It Works**
1. **Words Turn Into Numbers:**
   - Players start by submitting a list of words. Each word gets hashed into a number, and that number is then converted into the nearest prime.
   - The product of all those primes forms the secret product, which is stored on the blockchain. 

2. **Your Challenge:**
   - During the game, you’ll see a series of word hints. Each word corresponds to a prime factor of the secret product.
   - You’ll make your guesses by submitting the primes you think match the words. The more primes you get right, the higher your score.

3. **Scoring:**
   - When you make a guess, the system compares your guess to the original product and calculates the **gcd** (Greatest Common Divisor).
   - The higher the gcd, the more correct your guess is. You’re ranked based on how close your guess is to the original product.

### **Game Mechanics**
- **Guessing:** You can guess one or more words at a time. Each word is tied to a prime number. Your goal is to correctly guess the primes that make up the secret product.
- **Validating Guesses:** To keep the game fair, the system checks:
  - **Prime numbers:** All guessed numbers must be prime.
  - **No repeats:** You can’t guess the same prime twice in a round.
  - **Correct overlap:** The system uses the **gcd** to make sure your guesses are valid and close to the real product.

### **Why "Hashed Words"?**
The name "Hashed Words" comes from the way words are turned into numbers (hashed) and used to form a product. It’s a mix of wordplay and math, where each word is a clue leading you to the right number.

### **A Game of Numbers**
At its heart, **Hashed Words** is a fun and challenging numbers game. You’ll be figuring out which primes fit with the words and trying to guess as many as you can to rack up your score. It’s all about making smart guesses and thinking through the hints to uncover the secret product!

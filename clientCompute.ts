import { keccak256, toHex } from 'viem';

function wordToHash(word: string): bigint {

    return BigInt(`${toHex(word)}`);
}

// Example usage
const word = "boys";
const hash = wordToHash(word);
console.log(`Bigint for "${word}":`, hash.toString());
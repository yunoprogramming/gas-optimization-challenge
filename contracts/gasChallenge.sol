// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract gasChallenge {

    // Using a fixed-size array
    uint8[10] numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]; 

    function getSumOfArray() public view returns (uint256) {
        uint sum = 0;
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
    
    function notOptimizedFunction() public {
        for (uint i = 0; i < numbers.length; i++) {
            numbers[i] = 0;
        }
    }
    
    function optimizedFunction() public {
        // Cache the 'numbers' state variable in a local variable to reduce storage reads
        uint8[10] memory cachedNumbers = numbers;
        
        uint sum = 0;
        // Use for loop with fixed step size (1) to reduce gas consumption
        for (uint i = 0; i < cachedNumbers.length; i += 1) {
            // Use unchecked block to skip integer overflow check
            unchecked {
                sum += cachedNumbers[i];
            }
        }
        // Assign the calculated sum directly to the 'numbers' state variable
        numbers = [uint8(0), 0, 0, 0, 0, 0, 0, 0, 0, 0];
    }
}

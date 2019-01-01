import Foundation
import Accelerate
/*
 735. Asteroid Collision
 
 We are given an array asteroids of integers representing asteroids in a row.
 
 For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.
 
 Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.
 
 Example 1:
 
    Input:
    asteroids = [5, 10, -5]
    Output: [5, 10]
 
    Explanation:
    The 10 and -5 collide resulting in 10.  The 5 and 10 never collide.

 Example 2:
 
    Input:
    asteroids = [8, -8]
    Output: []
 
    Explanation:
    The 8 and -8 collide exploding each other.
 
 Example 3:
 
    Input:
    asteroids = [10, 2, -5]
    Output: [10]
 
    Explanation:
    The 2 and -5 collide resulting in -5.  The 10 and -5 collide resulting in 10.

 Example 4:
 
    Input:
    asteroids = [-2, -1, 1, 2]
    Output: [-2, -1, 1, 2]
 
    Explanation:
    The -2 and -1 are moving left, while the 1 and 2 are moving right.
    Asteroids moving the same direction never meet, so no asteroids will meet each other.
 
    Note:
    The length of asteroids will be at most 10000.
    Each asteroid will be a non-zero integer in the range [-1000, 1000]..
 */

class Solution {
    func asteroidCollision(_ asteroids: [Int]) -> [Int] {
        // Approach:
        // Construct Negative & Positive Stack
        // Only calculate the collision for negative items since we are iterating left to right
        //  React based on collision (same/less/more)
        var negativeStack: [Int] = []
        var positiveStack: [Int] = []
        
        // Configure Array to have full capacity allocated for more performant append/remove
        negativeStack.reserveCapacity(asteroids.count)
        positiveStack.reserveCapacity(asteroids.count)
        
        for asteroid in asteroids {
            // Negative Asteroid
            if asteroid < 0 {
                if positiveStack.isEmpty {
                    negativeStack.append(asteroid)
                } else {
                    // Inspect current asteroid relative negatives
                    // How do we loop through the stack if large value?
                    // We want to pop items off the stack until we have satisfied this or the other stack is destroyed
                    var shouldContinue = true
                    while shouldContinue {
                        if let last = positiveStack.last {
                            
                            // Same Value - Destroy Both
                            if last == abs(asteroid) {
                                positiveStack.removeLast()
                                shouldContinue = false
                            }
                            // New Asteroid is smaller (destroy new value)
                            else if last > abs(asteroid) {
                                shouldContinue = false
                            }
                            // New Asteroid is bigger (destroy old value)
                            else {
                                positiveStack.removeLast()
                            }
                        } else {
                            negativeStack.append(asteroid)
                            shouldContinue = false
                        }
                    }
                }
            }
            // Positive Asteroid
            // We only need to calculate this in one direction
            else {
                positiveStack.append(asteroid)
            }
        }
        
        return negativeStack + positiveStack
    }
}

// Tests
Solution().asteroidCollision([5,10,-5]) == [5,10]
Solution().asteroidCollision([8,-8]) == []
Solution().asteroidCollision([10,2,-5]) == [10]
Solution().asteroidCollision([-2,-1,1,2]) == [-2,-1,1,2]
Solution().asteroidCollision([-2,-1,1,2])
Solution().asteroidCollision([-3,1,2,1,-1,-2,1])

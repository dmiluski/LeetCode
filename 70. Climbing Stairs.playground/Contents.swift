import Foundation

/*
 70. Climbing Stairs
 Easy

 You are climbing a stair case. It takes n steps to reach to the top.

 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

 Note: Given n will be a positive integer.

 Example 1:

 Input: 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps
 Example 2:

 Input: 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step
 */

class Solution {

    /*
     Approach - Recursion

     Similar to (55) Jump Game we can step through an array of items and try each variant

     This problem differs in that each step can take on 1 of 2 options. Rathe that declare if we're able
     to succeed, we're looking to sum up each option

     Given it's recursive, we're likely to see duplicates. To save time recursing down paths multiple times
     we can memoize options.
     */

    /// Recursively Finds Unique ways of reaching the end of a number of stairs
    /// - parameters:
    ///		- n: number of Stairs
    ///		- memoizedStorage: reference to storage for cached lookups of uniqe ways once <x> steps from end
    /// - returns: Number of unique ways to take n steps
    private func recurseClimbStairs(_ n: Int,
                                    memoizedReference: inout [Int: Int]) -> Int {


        if n < 0 {
            // Sentinel Check - Too Far
            return 0
        } else if n == 0 {
            // Sentinel Check - Found end
            return 1
        } else {
            // Recurse options
            // We have two options 1, or 2
            // First Check Memoized Storage, then fall through to manually checking
            let oneStep = memoizedReference[n-1] ?? recurseClimbStairs(n-1, memoizedReference: &memoizedReference)
            let twoSteps = memoizedReference[n-2] ?? recurseClimbStairs(n-2, memoizedReference: &memoizedReference)

            // Update Counts
            memoizedReference[n-1] = oneStep
            memoizedReference[n-2] = twoSteps

            return oneStep + twoSteps
        }
    }

    /// Finds Unique ways of reaching the end of a number of stairs
    /// - parameters:
    ///        - n: number of Stairs (Expects Positive value)
    ///        - memoizedStorage: reference to storage for cached lookups
    /// - returns: Number of unique ways to take n steps
    func climbStairs(_ n: Int) -> Int {
        guard n > 0 else { return 0 }

        var storage = [Int: Int]()
        return recurseClimbStairs(n, memoizedReference: &storage)
    }
}

Solution().climbStairs(2)
Solution().climbStairs(3)
Solution().climbStairs(4)
Solution().climbStairs(44)

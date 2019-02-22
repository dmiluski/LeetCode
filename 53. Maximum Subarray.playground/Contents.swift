import Foundation

/*
 53. Maximum Subarray (AKA Max Contiguous)

 Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

 Example:

 Input: [-2,1,-3,4,-1,2,1,-5,4],
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 Follow up:

 If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
 */

extension Array where Element == Int {
    /* O(n) Sum of elements */
    var sum: Int {
        return self.reduce(into: 0, +=)
    }
}

/*
 Approach:
 Given we don't need to keep track of the actual subset, we can focus on a running total

 Kadane’s Algorithm:

 Initialize:
 max_so_far = 0
 max_ending_here = 0

 Loop for each element of the array
 (a) max_ending_here = max_ending_here + a[i]
 (b) if(max_ending_here < 0)
 max_ending_here = 0
 (c) if(max_so_far < max_ending_here)
 max_so_far = max_ending_here
 return max_so_far

 Explanation:
 Simple idea of the Kadane’s algorithm is to look for all positive contiguous segments of the array (max_ending_here is used for this). And keep track of maximum sum contiguous segment among all positive segments (max_so_far is used for this). Each time we get a positive sum compare it with max_so_far and update max_so_far if it is greater than max_so_far
 */
class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {

        // Require at least 1 value, means we can't default to 0
        // subset of 0 items == 0
        guard let first = nums.first else { return 0 }
        var maxSoFar = first
        var maxEndingHere = first

        for value in nums[1...] {
            // Inspect New MaxEndingHere
            maxEndingHere = maxEndingHere + value

            // Require minimum to be at lowest the new value,
            maxEndingHere = max(maxEndingHere, value)

            // If maxEndingHere is larger, update maxSoFar
            maxSoFar = max(maxSoFar, maxEndingHere)
        }
        return maxSoFar
    }
}



// Test
Solution().maxSubArray([-2,1,-3,4,-1,2,1,-5,4]) == 6
Solution().maxSubArray([-1]) == -1
Solution().maxSubArray([-2,1]) == 1
Solution().maxSubArray([1,-2]) == 1
Solution().maxSubArray([1,-2,1,1]) == 2
Solution().maxSubArray([-2,-1]) == -1


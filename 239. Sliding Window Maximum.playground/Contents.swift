import Foundation
/*
 239. Sliding Window Maximum
 Hard

 Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position. Return the max sliding window.

 Example:

 Input: nums = [1,3,-1,-3,5,3,6,7], and k = 3
 Output: [3,3,5,5,6,7]
 Explanation:

 Window position                Max
 ---------------               -----
 [1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
 Note:
 You may assume k is always valid, 1 ≤ k ≤ input array's size for non-empty array.

 Follow up:
 Could you solve it in linear time?
 */

class Solution {

    // Steps
    // 1. Iterate through array
    // 2. Find Max
    //      - If done with max this will be done  in O(n*k)
    //
    // Given we pass in k items

    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {

        // Out of bounds k
        guard k > 0,
            nums.count >= k else { return [] }

        var output: [Int] = []
        output.reserveCapacity(nums.count - k)

        var lowerBounds = 0

        // Iterate of Sliding Window, inspect max, append
        while lowerBounds <= nums.count - k {
            let subset = nums[lowerBounds..<lowerBounds+k]
            output.append(subset.max()!)
            lowerBounds += 1
        }

        return output
    }
}

Solution().maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3)

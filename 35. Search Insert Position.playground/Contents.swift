import Foundation

/*
 35. Search Insert Position

 Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

 You may assume no duplicates in the array.

 Example 1:

 Input: [1,3,5,6], 5
 Output: 2
 Example 2:

 Input: [1,3,5,6], 2
 Output: 1
 Example 3:

 Input: [1,3,5,6], 7
 Output: 4
 Example 4:

 Input: [1,3,5,6], 0
 Output: 0

 */

class Solution {
    // Seems very similar to a Binary Search
    // What makes a binary search difficult: The pivot Unknown
    //
    // Goal O(log(n)) performance
    // Basic firstIndex(:) performs at O(n)
    //
    // Key Peices of Info
    // Can assume no duplicates
    // Ordered although rotated
    func search(_ nums: [Int], _ target: Int) -> Int {
        var lowIndex = 0
        var upperIndex = nums.count - 1
        var outputIndex = 0

        while lowIndex <= upperIndex {
            let midIndex = abs((lowIndex + upperIndex) / 2)

            // Value Comparisons
            if nums[lowIndex] == target {
                return lowIndex
            } else if nums[upperIndex] == target {
                return upperIndex
            } else if nums[midIndex] == target {
                return midIndex
            }

            // Determining Next Bucket to search
            if target < nums[lowIndex] {
                return lowIndex
            } else if (nums[lowIndex]..<nums[midIndex]).contains(target) {
                upperIndex = midIndex - 1
                outputIndex = midIndex
            } else if (nums[midIndex]..<nums[upperIndex]).contains(target) {
                lowIndex = midIndex + 1
                outputIndex = midIndex
            } else {
                return upperIndex + 1
            }
        }
        return outputIndex
    }
}

// Tests
let input = [1,3,5,6]
Solution().search(input, 5) == 2
Solution().search(input, 2) == 1
Solution().search(input, 7) == 4
Solution().search(input, 0) == 0
Solution().search([1], 2)



import Foundation

/*
 33. Search in Rotated Sorted Array

 Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

 (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

 You are given a target value to search. If found in the array return its index, otherwise return -1.

 You may assume no duplicate exists in the array.

 Your algorithm's runtime complexity must be in the order of O(log n).

 Example 1:

 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4
 Example 2:

 Input: nums = [4,5,6,7,0,1,2], target = 3
 Output: -1
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
        return nums.firstIndex(of: target) ?? -1
    }
}

// Only Applicable if Orderd
extension Array where Element == Int {
    // Requires Sorted array
    // Returns index of value
    func binarySearch(value: Int) -> Int? {
        var lowIndex = 0
        var upperIndex = count - 1

        while lowIndex < upperIndex {
            let midIndex = abs((lowIndex + upperIndex) / 2)

            // Value Comparisons
            if self[lowIndex] == value {
                return lowIndex
            } else if self[upperIndex] == value {
                return upperIndex
            } else if self[midIndex] == value {
                return midIndex
            }

            // Determining Next Bucket to search
            if (self[lowIndex]..<self[midIndex]).contains(value) {
                upperIndex = midIndex
            } else {
                lowIndex = midIndex
            }
        }
        return nil
    }

    // Requires Sorted, unique, allows for rotation rotated
    func rotatedBinarySearch(target: Int) -> Int? {
        var lowIndex = 0
        var upperIndex = count - 1

        while lowIndex < upperIndex {
            let midIndex = abs((lowIndex + upperIndex) / 2)

            let comparator: Int
            // Checking if both target and nums[mid] are on same side.
            if((target < self[0]) &&
                (self[midIndex] < self[0]) || (target >= self[0]) &&
                (self[midIndex] >= self[0])) {
                comparator = self[midIndex]
            } else {
                // Trying to figure out where nums[mid] is and making comparator as -INF or INF
                comparator = (target < self[0]) ? Int.min : Int.max
            }

            // Value Comparisons
            if self[lowIndex] == target {
                return lowIndex
            } else if self[upperIndex] == target {
                return upperIndex
            } else if self[midIndex] == target {
                return midIndex
            }

            // Update Boundaries
            if(target > comparator) {
                lowIndex = midIndex
            } else {
                upperIndex = midIndex
            }

        }
        return nil
    }
}
[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25].binarySearch(value: 7)


let inputv1 = [4,5,6,7,0,1,2]
let inputv2 = [4,5,6,7,0,1,2]
let inputv3 = [8,9,10,1,2,3,4,5,6,7]
let inputv4 = [0, 1, 2, 3, 4, -5, -4, -3, -2, -1]

Solution().search(inputv1, 0) == 4
Solution().search(inputv2, 3) == -1
Solution().search(inputv3, 6)
Solution().search(inputv4, -1)


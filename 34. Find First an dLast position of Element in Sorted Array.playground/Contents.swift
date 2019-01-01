import Foundation

/*
 34. Find First and Last Position of Element in Sorted Array

 Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.

 Your algorithm's runtime complexity must be in the order of O(log n).

 If the target is not found in the array, return [-1, -1].

 Example 1:

 Input: nums = [5,7,7,8,8,10], target = 8
 Output: [3,4]
 Example 2:

 Input: nums = [5,7,7,8,8,10], target = 6
 Output: [-1,-1]
 */

class Solution {
    // Seems very similar to a Binary Search
    //
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let lowerBounds = nums.binaryFirstIndex(target) ?? -1
        let upperBounds = nums.binaryLastIndex(target) ?? -1
        return [lowerBounds, upperBounds]
    }

    /// - Complexity: O(*n*), where *n* is the length of the collection.
    func systemEquivalentSearchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let lowerBounds = nums.firstIndex(of: target) ?? -1
        let upperBounds = nums.lastIndex(of: target) ?? -1
        return [lowerBounds, upperBounds]
    }}

// Only Applicable if Orderd
extension Array where Element == Int {

    // Requires Sorted Arrays
    func binaryFirstIndex(_ value: Int) -> Int? {
        var lowIndex = 0
        var upperIndex = count - 1
        var firstIndexOfValue: Int?

        while lowIndex <= upperIndex {
            let midIndex = abs((lowIndex + upperIndex) / 2)

            // Value Comparisons
            if self[lowIndex] == value {
                firstIndexOfValue = Swift.min(firstIndexOfValue ?? lowIndex, lowIndex)
            }
            if self[midIndex] == value {
                firstIndexOfValue = Swift.min(firstIndexOfValue ?? midIndex, midIndex)
            }
            if self[upperIndex] == value {
                firstIndexOfValue = Swift.min(firstIndexOfValue ?? upperIndex, upperIndex)
            }

            // Determining Next Bucket to search Opting to bias lower
            if (self[lowIndex]...self[midIndex]).contains(value) {
                upperIndex = midIndex - 1
            } else {
                lowIndex = midIndex + 1
            }
        }
        return firstIndexOfValue
    }

    func binaryLastIndex(_ value: Int) -> Int? {
        var lowIndex = 0
        var upperIndex = count - 1
        var firstIndexOfValue: Int?

        while lowIndex <= upperIndex {
            let midIndex = abs((lowIndex + upperIndex) / 2)

            // Value Comparisons (Consider all options rather than if/else)
            if self[lowIndex] == value {
                firstIndexOfValue = Swift.max(firstIndexOfValue ?? lowIndex, lowIndex)
            }
            if self[midIndex] == value {
                firstIndexOfValue = Swift.max(firstIndexOfValue ?? midIndex, midIndex)
            }
            if self[upperIndex] == value {
                firstIndexOfValue = Swift.max(firstIndexOfValue ?? upperIndex, upperIndex)
            }

            // Determining Next Bucket to search Opting to bias higher
            if (self[midIndex]...self[upperIndex]).contains(value) {
                lowIndex = midIndex + 1
            } else {
                upperIndex = midIndex - 1
            }
        }
        return firstIndexOfValue
    }
}


let inputv1 = [5,7,7,8,8,10]
let inputv2 = [5,7,7,8,8,10]
let inputv3 = [1,2,3,4,4,4,4,4,4,5,6,7]

// Equivalency, but this is more performant
Solution().searchRange(inputv1, 8) == Solution().systemEquivalentSearchRange(inputv1, 8)
Solution().searchRange(inputv2, 6) == Solution().systemEquivalentSearchRange(inputv2, 6)
Solution().searchRange(inputv3, 4) == Solution().systemEquivalentSearchRange(inputv3, 4)


Solution().searchRange([1], 1)


import Foundation

/*
 75. Sort Colors
 Medium

 Given an array with n objects colored red, white or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white and blue.

 Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.

 Note: You are not suppose to use the library's sort function for this problem.

 Example:

 Input: [2,0,2,1,1,0]
 Output: [0,0,1,1,2,2]
 Follow up:

 A rather straight forward solution is a two-pass algorithm using counting sort.
 First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total number of 0's, then 1's and followed by 2's.
 Could you come up with a one-pass algorithm using only constant space?
 */

class Solution {

    // Approach:
    // We do have system sort() available, but that performance is at best nLog(n) (Quicksort)
    // We know we have items limited to values 0,1,2 (Integers), rather than swap values at locations
    // we have the option of writing directly
    private func sortColorsTwoPass(_ nums: inout [Int]) {

        // Count Model
        var zeroCount = 0
        var oneCount = 1
        var twoCount = 2

        // Count up each
        nums.forEach { (value) in
            switch value {
            case 0: zeroCount += 1
            case 1: oneCount += 1
            case 2: twoCount += 1
            default:
                fatalError()
            }
        }

        nums
            .indices
            .forEach { (index) in

                if zeroCount > 0 {
                    zeroCount -= 1
                    nums[index] = 0
                } else if oneCount > 0 {
                    oneCount -= 1
                    nums[index] = 1
                } else {
                    twoCount -= 1
                    nums[index] = 2
                }
        }
    }

    // Given we know output is in a known order and increasing, we can assume we have groups of low, medium, high
    // Tackle by iterating the array and swapping into low or high section
    private func sortColorsOnePass(_ nums: inout [Int]) {

        // Count Up Indexes
        var lowIndex = 0
        var midIndex = 0

        // Count Down Index
        var highIndex = nums.count - 1

        while midIndex <= highIndex {
            switch nums[midIndex] {
            case RGB.blue.rawValue:
                // If Blue, move to the tail of the array, reattempt same index check next loop
                nums.swapAt(midIndex, highIndex)
                highIndex -= 1
            case RGB.red.rawValue:
                // If Red, swap with low index (order items we've already passed)
                nums.swapAt(lowIndex, midIndex)
                lowIndex += 1
                midIndex += 1
            default:
                midIndex += 1
            }
        }
    }

    func sortColors(_ nums: inout [Int]) {
        return sortColorsOnePass(&nums)
    }
}

enum RGB: Int {
    case red = 0
    case green = 1
    case blue = 2
}

var input1 = [2,0,2,1,1,0]
Solution().sortColors(&input1)
input1

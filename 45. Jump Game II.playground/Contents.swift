import Foundation

/*
 45. Jump Game

 Given an array of non-negative integers, you are initially positioned at the first index of the array.

 Each element in the array represents your maximum jump length at that position.

 Your goal is to reach the last index in the minimum number of jumps.

 Example:

    Input: [2,3,1,1,4]
    Output: 2

    Explanation: The minimum number of jumps to reach the last index is 2.

    Jump 1 step from index 0 to 1, then 3 steps to the last index.

 Note:
 You can assume that you can always reach the last index.
*/


/*
 Approach:
 No Order: We don't know what's in front of us
 Pattern: There is not a set distance between, so no dynamic programming

 The only approach I can think of now is a similar decision fork recursion approach
 where we attempt each option for the value at index/
 */
class Solution {

    // An alternative, is to use inout array and not copy over and over?
    func recurseJump(_ nums: [Int]) -> Int? {
        guard let num = nums.first else { return 1 }

        var jumps: [Int] = []
        for jumpOption in 1...num {
            guard let index = nums.index(0, offsetBy: jumpOption, limitedBy: nums.count - 1) else {
                continue
            }

            if index == nums.count - 1 {
                return 1
            }
            guard let output = recurseJump(Array(nums.suffix(from: index))) else {
                continue
            }

            jumps.append(output)
        }
        guard let min = jumps.min() else { return nil }
        return min + 1
    }

    func jump(_ nums: [Int]) -> Int {
        return recurseJump(nums) ?? -1
    }
}

// Tests
Solution().jump([2,3,1,1,4]) == 2


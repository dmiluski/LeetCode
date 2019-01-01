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
    // B/c of this recursive approach and appraoch, this does not scale with lengthy
    //
    //  Given it accomplishes what it sets out to do, can we optimize?
    //
    //  A lot of the time spent is calculating paths through steps multiple times
    //  Perhaps we can memoize value to speed up future iterations
    func recurseJump(_ nums: [Int]) -> Int? {
        // If empty, or went beyond the end, invalid
        guard let num = nums.first else { return nil }

        // Sentinal - We found the final item
        if nums.count == 1 {
            return 0
        }

        // If 0, we're stuck. Are we already at the end
        if num == 0 {
            return nums.count > 1 ? nil : 0
        }

        var jumps: [Int] = []


        // My Previous assumption assumed we had to have at least 1 jump?
        //
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
Solution().jump([0]) == 0
Solution().jump([1]) == 0

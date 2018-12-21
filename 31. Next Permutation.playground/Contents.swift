import Foundation

/*
 31. Next Permutation

 Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.

 If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).

 The replacement must be in-place and use only constant extra memory.

 Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.

 1,2,3 → 1,3,2
 3,2,1 → 1,2,3
 1,1,5 → 1,5,1
 */

class Solution {
    func nextPermutation(_ nums: inout [Int]) {

    }
}

// Tests
var inputv1 = [1,2,3]
var inputv2 = [3,2,1]
var inputv3 = [1,1,5]

Solution().nextPermutation(&inputv1)
Solution().nextPermutation(&inputv2)
Solution().nextPermutation(&inputv3)

inputv1 == [1,3,2]
inputv2 = [1,2,3]
inputv3 = [1,5,1]

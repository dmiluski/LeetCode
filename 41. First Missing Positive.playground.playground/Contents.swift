import Foundation

/*
 41. First Missing Positive

 Given an unsorted integer array, find the smallest missing positive integer.

 Your algorithm should run in O(n) time and uses constant extra space.
 */

/*
 Approach:
 Given an array can have multiple missing integers ranges, keeping individual variables (high/low)
 does not provide a mechanism to keep track of multiple open ranges (eg. variable could lose refernce
 if array is sorted in decending order.

 Sorting:
 Sorting does us no good here as a sort would requie O(n * log(n))

 Seeing note ('constant') space makes me think we can either have 1-3 variables? Or an additional array the
 size of the input for managing data.

 Given we have an unsorted input, something that could assist us here is a BST (Balancing Insert)

 If we had a Red-Black Tree, we can insert at a rate of O(log(n)), then search O(log(n))

 Given Tree was created, we can walk the tree first searching for 1, if that is taken we can inspect children (given chilredn count)

 */


class Solution {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums

        // TODO:
        return nums.count
    }
}




// Tests
Solution().firstMissingPositive([1,2,0]) == 3
Solution().firstMissingPositive([3,4,-1,1]) == 2
Solution().firstMissingPositive([7,8,9,11,12]) == 1
Solution().firstMissingPositive([1,2,3,12,11,10,4])
Solution().firstMissingPositive([4,7,3,1,9,5,17,2])

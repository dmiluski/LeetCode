import Foundation

/*
 88. Merge Sorted Array
 Easy

 Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.

 Note:

 The number of elements initialized in nums1 and nums2 are m and n respectively.
 You may assume that nums1 has enough space (size that is greater or equal to m + n) to hold additional elements from nums2.
 Example:

 Input:
 nums1 = [1,2,3,0,0,0], m = 3
 nums2 = [2,5,6],       n = 3

 Output: [1,2,2,3,5,6]
 */

class Solution {

    // Approach:
    //  If we iterate through the nums1 array and insert, we would need to move each item afterwards
    //  Instead, given we know the extra space is already available, we can reverse iterate from nums1[count - 1 - n]
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {

        // Last Index of the array (O's section)
        var lastIndex = nums1.endIndex - 1

        // Last Index of the sorted nums1 values
        var nums1LastIndex = m - 1

        // Loop through nums2 reverse and compare with nums1 reversed values
        //
        nums2.reversed().forEach { (value) in

            // If value is not higher, loop to next index
            while lastIndex >= 0 {

                // Check if Value is larger? Or if there are no remaining originals
                if (nums1LastIndex >= 0 && value >= nums1[nums1LastIndex]) || nums1LastIndex < 0 {
                    nums1[lastIndex] = value
                    lastIndex -= 1
                    break
                } else {
                    nums1.swapAt(lastIndex, nums1LastIndex)
                    nums1LastIndex -= 1
                    lastIndex -= 1
                }
            }
        }
        return
    }
}

var nums1 = [1,2,3,0,0,0]
Solution().merge(&nums1, 3, [2,5,6], 3)
nums1 == [1,2,2,3,5,6]

var a = [0]
Solution().merge(&a, 0, [1], 1)
a == [1]

var b = [2,0]
Solution().merge(&b, 1, [1], 1)
b == [1,2]
b

var c = [0,0,3,0,0,0,0,0,0]
Solution().merge(&c, 3, [-1,1,1,1,2,3], 6)
c == [-1,0,0,1,1,1,2,3,3]
c

// Test Catches > comparisons against zero given zero was just a placeholder
var e = [-50,-50,-48,-47,-44,-44,-37,-35,-35,-32,-32,-31,-29,-29,-28,-26,-24,-23,-23,-21,-20,-19,-17,-15,-14,-12,-12,-11,-10,-9,-8,-5,-2,-2,1,1,3,4,4,7,7,7,9,10,11,12,14,16,17,18,21,21,24,31,33,34,35,36,41,41,46,48,48]

var d = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Solution().merge(&d, 0, [-50, -50, -48, -47, -44, -44, -37, -35, -35, -32, -32, -31, -29, -29, -28, -26, -24, -23, -23, -21, -20, -19, -17, -15, -14, -12, -12, -11, -10, -9, -8, -5, -2, -2, 1, 1, 3, 4, 4, 7, 7, 7, 9, 10, 11, 12, 14, 16, 17, 18, 21, 21, 24, 31, 33, 34, 35, 36, 41, 41, 46, 48, 48], 63)
d == [-50, -50,  -48, -47, -44, -44,-37,-35, -35, -32, -32, -31, -29, -29, -28, -26, -24, -23, -23, -21, -20, -19, -17, -15, -14, -12, -12, -11, -10, -9, -8, -5, -2, -2, 1, 1, 3, 4, 4, 7, 7, 7, 9, 10, 11, 12, 14, 16, 17, 18, 21, 21, 24, 31, 33, 34, 35, 36, 41 ,41, 46, 48, 48]

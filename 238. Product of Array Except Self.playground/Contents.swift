import Foundation
/*
 238. Product of Array Except Self

 Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
 
 Example:
 
    Input:  [1,2,3,4]
    Output: [24,12,8,6]
 
    Note: Please solve it without division and in O(n).
 
 Follow up:
 Could you solve it with constant space complexity? (The output array does not count as extra space for the purpose of space complexity analysis.)
 */

class Solution {
    
    /*
     Approach:
        1. If we were to use division we could create the full array product,
        then divide by current item to calculate? O(n) Unfortunately, this is
        strictly called out, not to do.
     
        2. If we were to Calculate individdually, it would take O(n^2) to lookup
     
        3. Given the obvious hint to use a result array as a buffer, we can
        calculate the product by making 1 pass right, then one pass left to place
        the necessary components to calculate the product.
     
        By making a pass right, then back left, we can perform the calculations,
        and carry our value, which applies self's value to the elements left & right,
        but not to the index i
     
        Performance: O(N)
     */
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result = [Int](repeating: 0, count: nums.count)
        
        // Calculate Running Products Right (Initial is 1)
        var product = 1
        for (index, value) in nums.enumerated() {
            result[index] = product
            product *= value
        }
        
        // Calculate Running products Left (Reset Initial to 1)
        product = 1
        for index in (0..<nums.count).reversed() {
            result[index] *= product
            product *= nums[index]
        }

        return result
    }
}

// Tests:
Solution().productExceptSelf([1,2,3,4])
Solution().productExceptSelf([1,2,3,4]) == [24,12,8,6]

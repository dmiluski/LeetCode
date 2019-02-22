import Foundation

/*
 Given a non-empty array of digits representing a non-negative integer, plus one to the integer.

 The digits are stored such that the most significant digit is at the head of the list, and each element in the array contain a single digit.

 You may assume the integer does not contain any leading zero, except the number 0 itself.

 Example 1:

 Input: [1,2,3]
 Output: [1,2,4]
 Explanation: The array represents the integer 123.
 Example 2:

 Input: [4,3,2,1]
 Output: [4,3,2,2]
 Explanation: The array represents the integer 4321.
 */

class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {

        // Initial Carry is the first addition
        var carry = 1

        // Map Existing Collection Size
        var output = digits.reversed().map { (value) -> Int in
            let sum = value + carry
            carry = sum / 10    // New Carry
            return sum % 10     // Remainder
        }

        // Include Carry if Exists
        if carry > 0 {
            output.append(carry)
        }

        // Custruct Expected Output
        return Array(output.reversed())
    }
}

Solution().plusOne([1,2,3]) == [1,2,4]
Solution().plusOne([4,3,2,1]) == [4,3,2,2]

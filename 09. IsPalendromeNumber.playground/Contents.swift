//: Playground - noun: a place where people can play

import UIKit

/*
 Problem: 9

 Palindrome Number

 Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.

 Example 1:

 Input: 121
 Output: true
 Example 2:

 Input: -121
 Output: false
 Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
 Example 3:

 Input: 10
 Output: false
 Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
 Follow up:

 Coud you solve it without converting the integer to a string?
 */


// Approach 1
//  Convert to a string and compare with reverse
class Solution1 {
    func isPalindrome(_ x: Int) -> Bool {
        return String(x) == String(String(x).reversed())
    }
}

// Approach 2
//  Convert to String and compare string indexes manually
extension String {
    var isPalindrome: Bool {
        var lowerIndex = 0
        var upperIndex = count - 1

        let chars = Array(self)
        while lowerIndex < upperIndex {

            if chars[lowerIndex] != chars[upperIndex] {
                return false
            }
            lowerIndex += 1
            upperIndex -= 1
        }
        return true
    }
}

class Solution2 {
    func isPalindrome(_ x: Int) -> Bool {
        print(String(x))
        print(String(x).isPalindrome)
        return String(x).isPalindrome
    }
}

// Approach 3
//  Extract Individual Int numbers into array and compare across indexes
//  Similar to the Int work with Powers
class Solution3 {
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        var mutableValue = x
        var values: [Int] = []

        // Extract Digits to array
        while mutableValue > 0 {
            let remainder = mutableValue % 10
            values.append(remainder)
            mutableValue = mutableValue / 10
        }

        return values.isPalindrome
    }
}

extension Array where Element: Equatable {
    var isPalindrome: Bool {
        var lowerIndex = 0
        var upperIndex = count - 1

        while lowerIndex < upperIndex {

            if self[lowerIndex] != self[upperIndex] {
                return false
            }
            lowerIndex += 1
            upperIndex -= 1
        }
        return true
    }
}

// Tests
Solution1().isPalindrome(121) == true
Solution1().isPalindrome(1221) == true
Solution1().isPalindrome(-121) == false
Solution1().isPalindrome(10) == false

Solution2().isPalindrome(121) == true
Solution2().isPalindrome(1221) == true
Solution2().isPalindrome(-121) == false
Solution2().isPalindrome(10) == false

Solution3().isPalindrome(121) == true
Solution3().isPalindrome(1221) == true
Solution3().isPalindrome(-121) == false
Solution3().isPalindrome(10) == false


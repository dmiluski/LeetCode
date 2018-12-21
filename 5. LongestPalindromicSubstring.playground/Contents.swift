//: Playground - noun: a place where people can play

import UIKit

/*
 Problem 5

 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

 Example 1:

 Input: "babad"
 Output: "bab"
 Note: "aba" is also a valid answer.
 Example 2:

 Input: "cbbd"
 Output: "bb"
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {

        var longestString: String = ""
        var currentSubString: String = ""

        for char in s {

            // TODO: Brute Force O(n^3)

            // Some Better an O(n^2)

            // Hella cool one in O(n) Manchester Algorithm
        }

        return longestString
    }
}

extension String {
    var isPalindrome: Bool {
        var lowerIndex = 0
        var upperIndex = count - 1

        while lowerIndex < upperIndex {

            if [lowerIndex] != [upperIndex] {
                return false
            }
            lowerIndex += 1
            upperIndex -= 1
        }
        return true
    }
}


// Tests
Solution().longestPalindrome("babad") == "bab"
Solution().longestPalindrome("cbbd") == "bb"


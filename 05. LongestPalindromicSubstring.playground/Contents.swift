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

    // Manual Check without extra memory
    var isPalindrome: Bool {
        return String(self.reversed()) == self
    }
}


// Tests
Solution().longestPalindrome("babad") == "bab"
Solution().longestPalindrome("cbbd") == "bb"


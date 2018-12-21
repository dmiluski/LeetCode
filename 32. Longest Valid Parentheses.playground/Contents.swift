import Foundation

/*
 32. Longest Valid Parentheses

 Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.

 Example 1:

 Input: "(()"
 Output: 2
 Explanation: The longest valid parentheses substring is "()"
 Example 2:

 Input: ")()())"
 Output: 4
 Explanation: The longest valid parentheses substring is "()()"
 */

// Approach:
// Keep Running MaxValidCount
// Keep running currentCount
// Reset count upon reaching invalid Character

enum Parentheses: Character {
    case open = "("
    case close = ")"
}

/*
 https://leetcode.com/problems/longest-valid-parentheses/solution/

 This problem can be solved by using Dynamic Programming. We make use of a
 dp array where ith element of dp represents the length of the longest valid
 substring ending at ith index. We initialize the complete dp array with 0's.
 Now, it's obvious that the valid substrings must end with‘)’. This further
 leads to the conclusion that the substrings ending with ‘(’ will always
 contain '0' at their corresponding dp indices. Thus, we update the dp array
 only when ‘)’ is encountered.

 To fill dp array we will check every two consecutive characters of the string and if

 1. We do so because the ending "()" portion is a valid substring anyhow and leads to an increment of 2 in the length of the just previous valid substring's length.
 2. 
 */
class Solution {
    /*
     Complexity Analysis

     Time complexity :
     O(n): Single traversal of string to fill dp array is done.

     Space complexity :
     O(n): dp array of size n is used
     */
    func longestValidParentheses(_ s: String) -> Int {
        var longestValidParentheses = 0

        // Dynamic Programming Reference Array
        var dynamic: [Int] = Array(repeating: 0, count: s.count)
        let characters = Array(s)

        for (index, character) in s.enumerated() {
            guard index > 0 else { continue }

            if character == ")" {
                if characters[index-1] == "(" {
                    dynamic[index] = (index >= 2 ? dynamic[index - 2] : 0) + 2
                } else if (index - dynamic[index - 1] > 0 && characters[index - dynamic[index - 1] - 1] == "(") {
                    dynamic[index] = dynamic[index - 1] + ((index - dynamic[index - 1]) >= 2 ? dynamic[index - dynamic[index - 1] - 2] : 0) + 2
                }
                longestValidParentheses = max(longestValidParentheses, dynamic[index])
            }

        }
        return longestValidParentheses
    }
}

// Tests
var inputv1 = "(()"
var inputv2 = ")()())"
var inputv3 = "()()()()"

Solution().longestValidParentheses(inputv1)
Solution().longestValidParentheses(inputv1) == 2
Solution().longestValidParentheses(inputv2) == 4
Solution().longestValidParentheses(inputv3) == 8



let s = "something"
s.suffix(from: s.index(s.startIndex, offsetBy: 9))


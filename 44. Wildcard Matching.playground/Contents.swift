import Foundation

/*
 44. Wildcard Matching

 Given an input string (s) and a pattern (p), implement wildcard pattern matching with support for '?' and '*'.

 '?' Matches any single character.
 '*' Matches any sequence of characters (including the empty sequence).
 The matching should cover the entire input string (not partial).

 Note:

 s could be empty and contains only lowercase letters a-z.
 p could be empty and contains only lowercase letters a-z, and characters like ? or *.

 Example 1:
    Input:
        s = "aa"
        p = "a"
    Output: false
    Explanation: "a" does not match the entire string "aa".

 Example 2:
     Input:
        s = "aa"
        p = "*"
     Output: true

 Explanation: '*' matches any sequence.

 Example 3:
     Input:
        s = "cb"
        p = "?a"
     Output: false

 Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.

 Example 4:
    Input:
        s = "adceb"
        p = "*a*b"
    Output: true

 Explanation: The first '*' matches the empty sequence, while the second '*' matches the substring "dce".

 Example 5:
    Input:
        s = "acdcb"
        p = "a*c?b"
    Output: false

*/

/*
 Approach, this generall appears to act like a regular expression

 Fairly Straightforward Part:
    First matching character or ? to pattern
    1 to 1 Relationship

 More Complex Part:
    "*", where we are going to need to make a decision to to try with? or without?
    Fork Our decision on the variancies which are possible due to this character
 */
class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {

        // Sentinel Check - Success
        if s.isEmpty && p.isEmpty {
            return true
        }

        switch (s.first, p.first) {
        case (nil, "*"):
            // Empty Sequence Support
            return isMatch(s, String(p.suffix(from: p.index(after: p.startIndex))))
        case (_, "*"):
            // Wildcard Options
            // - Don't apply (empty sequence)
            // - Apply to This as well as next sequence
            // - Apply to Single Character
            return isMatch(s, String(p.suffix(from: p.index(after: p.startIndex)))) ||
                isMatch(String(s.suffix(from: s.index(after: s.startIndex))), p) ||
                isMatch(String(s.suffix(from: s.index(after: s.startIndex))), String(p.suffix(from: p.index(after: p.startIndex))))


        case (_?, "?"):
            return isMatch(String(s.suffix(from: s.index(after: s.startIndex))), String(p.suffix(from: p.index(after: p.startIndex))))

        case let (firstS?, firstP?):

            if firstS == firstP {
                return isMatch(String(s.suffix(from: s.index(after: s.startIndex))), String(p.suffix(from: p.index(after: p.startIndex))))
            } else {
                return false
            }
        default:
            return false
        }
    }
}

// Tests
Solution().isMatch("aa", "a") == false
Solution().isMatch("aa", "*") == true
Solution().isMatch("cb", "?a") == false
Solution().isMatch("adceb", "*a*b") == true
Solution().isMatch("acdcb", "a*c?b") == false

// Tests with Empty Sequence
Solution().isMatch("", "*") == true
Solution().isMatch("a", "a*") == true
Solution().isMatch("a", "a*b") == false


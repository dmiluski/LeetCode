//: Playground - noun: a place where people can play

import UIKit

/*
 Problem 10

 Regular Expression Matching

 Given an input string (s) and a pattern (p), implement regular expression matching with support for '.' and '*'.

 '.' Matches any single character.
 '*' Matches zero or more of the preceding element.
 The matching should cover the entire input string (not partial).

 Note:

 s could be empty and contains only lowercase letters a-z.
 p could be empty and contains only lowercase letters a-z, and characters like . or *.
 */

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        return isMatchHelper(s,p,nil)
    }

    private func isMatchHelper(_ s: String, _ p: String, _ previousPatternChar: Character?) -> Bool {


        let firstStringChar = s.first
        let firstPatternChar = p.first

        // Sentinal End Checks
        if firstStringChar == nil && firstPatternChar == nil {
            return true
        }

        if firstStringChar == nil {
            return false
        }

        switch firstPatternChar {

        // '.' Matches any single character.
        case "." where firstStringChar != nil:
            return isMatchHelper(String(s.dropFirst()), String(p.dropFirst()), firstPatternChar)

        // '*' Matches zero or more of the preceding element.
        case "*" where previousPatternChar != nil:
            switch previousPatternChar {
            case ".":

                // Given .* could go until the end
                // We need to allow for the possibility of any further string
                // matches after this character needing checked

                // Construct set of substrings
                var allTrailingOptions: [String] = []
                var v = s
                while !v.isEmpty {
                    v = String(v.dropFirst())
                    allTrailingOptions.append(v)
                }

                // Determine if any of the substrings match the suffix after .*
                return allTrailingOptions
                    .map( { (subString) -> Bool in
                        return self.isMatchHelper(subString, String(p.dropFirst()), nil)
                    })
                    .lazy
                    .filter({$0 == true})
                    .count > 0
            default:
                return isMatchHelper(String(s.dropFirst()), String(p.dropFirst()), nil)
            }
        default:
            return (firstStringChar == firstPatternChar) && isMatchHelper(String(s.dropFirst()), String(p.dropFirst()), firstPatternChar)
        }
    }
}

// Tests
Solution().isMatch("aa", "a") == false
Solution().isMatch("aa", "a*") == true
Solution().isMatch("ab", ".*") == true
Solution().isMatch("aab", "c*a*b") == false
Solution().isMatch("mississippi", "mis*is*p.") == false
Solution().isMatch("aabbbbbbbbbcc", "a.*") == true

// Test Suffix after .* is appropriately applied
Solution().isMatch("aabbbbbbbbbcc", "a.*d") == false
Solution().isMatch("aabbbbbbbbbcc", "a.*") == true
Solution().isMatch("aabbbbbbbbbcc", "a.b.*") == true

// Malformed or empty patterns
Solution().isMatch("a", "*") == false
Solution().isMatch("a", "") == false

// Multiple .* 0 or more wildcards
Solution().isMatch("aaaabbbbddd", "a.*b.*d") == true
Solution().isMatch("aaaabbbbddde", "a.*b.*d") == false








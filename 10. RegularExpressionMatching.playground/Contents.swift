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

    /// Determines if input String matches pattern provided
    /// - Parameters:
    ///     - s: Input String
    ///     - p: Input Pattern
    /// - Returns: Bool whether or not the string *s* follows patter *p*
    func isMatch(_ s: String,
                 _ p: String) -> Bool {
        return isMatchHelper(string: s,
                             pattern: p,
                             previousPatternCharacter: nil)
    }

    /// Determines if input String matches pattern provided
    ///
    /// - Parameters:
    ///     - s: Input String (In Reversed Order)
    ///     - p: Input Pattern (In Reversed Order)
    ///     - isSkippable: Bool (Whether or not character afterwards is * (Zero or more)
    ///     - priorCharacter: Set if '*' means we're able to skip, if available and matches we
    ///         may opt to skip
    ///
    /// - Note:
    ///     Takes Input *s* and *p* in reverse order given '*" character is dependent on prior character
    ///
    /// - Returns: Bool whether or not the string *s* follows patter *p*
    private func isMatchHelper(string: [Character],
                               pattern: [Character],
                               isSkippable: Bool,
                               priorCharacter: Character?) -> Bool {

        let firstStringChar = string.first
        let firstPatternChar = pattern.first

        // Success - Sentinal End Check (Both Empty)
        switch (firstStringChar, firstPatternChar) {

        // Sentinel Check - Success
        case (nil, nil): return true

        // Sentinel Check - Failure
        case (nil, _): return false

        // Matches Extended Prior Character
        case (let sFirst?, _) where sFirst == priorCharacter:
            // Either Re-Apply prior pattern character or move on
            let sNextIndex = string.index(string.startIndex, offsetBy: 1)
            let sNext = Array(string[sNextIndex...])

            return isMatchHelper(string:sNext,
                                 pattern: pattern,
                                 isSkippable: false,
                                 priorCharacter: priorCharacter) ||
                isMatchHelper(string:sNext,
                              pattern: pattern,
                              isSkippable: false,
                              priorCharacter: nil)

        // Matches Any Single Character
        case (let sFirst, ".") where isSkippable:

            return isMatchHelper(string:pattern:isSkippable:priorCharacter:)

        }
//        if firstStringChar == nil && firstPatternChar == nil {
//            return true
//        }
//
//        // Failure - Sentinel Check (Mis-Match)
//        if firstStringChar == nil {
//            return false
//        }
//
//        switch firstPatternChar {
//        case "." where firstStringChar != nil:
//                return isMatchHelper(string: String(string.dropFirst()),
//                                 pattern: String(pattern.dropFirst()),
//                                 isSkippable: false)
//        case "*":
//
//
//
//
//        }

    }


    /// Determines if input String matches pattern provided
    /// - Parameters:
    ///     - s: Input String
    ///     - p: Input Pattern
    ///     - previousPatternCharacter: Previous Pattern Character (Usefule for matching against '*' previous element)
    /// - Returns: Bool whether or not the string *s* follows patter *p*
//    private func isMatchHelper(string: String,
//                               pattern: String,
//                               previousPatternCharacter: Character?) -> Bool {
//
//        // Given * is determined by previous character, potentially parse backwards
//        print(string + " " + pattern)
//        let firstStringChar = string.first
//        let firstPatternChar = pattern.first
//
//        // Sentinal End Checks
//        if firstStringChar == nil && firstPatternChar == nil {
//            return true
//        }
//
//        if firstStringChar == nil {
//            return false
//        }
//
//        switch firstPatternChar {
//
//        case "." where isSkippable:
//            return isMatchHelper(string: String(string.dropFirst()),
//                                 pattern: String(pattern.dropFirst()),
//                                 previousPatternCharacter: firstPatternChar)
//        // '.' Matches any single character.
//        case "." where firstStringChar != nil:
//            return isMatchHelper(string: String(string.dropFirst()),
//                                 pattern: String(pattern.dropFirst()),
//                                 previousPatternCharacter: firstPatternChar)
//
//        // '*' Matches zero or more of the preceding element.
//        case "*":
//            return isMatchHelper(string: String(string.dropFirst()),
//                                 pattern: String(pattern.dropFirst()),
//                                 isSkippable: true)
//            switch previousPatternCharacter {
//        default:
//            return (firstStringChar == firstPatternChar) &&
//                isMatchHelper(string: String(string.dropFirst()),
//                              pattern: String(pattern.dropFirst()),
//                              previousPatternCharacter: firstPatternChar)
//        }
//    }
}

// Tests
//Solution().isMatch("aa", "a") == false
//Solution().isMatch("aa", "a*") == true
//Solution().isMatch("ab", ".*") == true
//Solution().isMatch("aab", "c*a*b") == false
//Solution().isMatch("mississippi", "mis*is*p.") == false
//Solution().isMatch("aabbbbbbbbbcc", "a.*") == true
//
//// Test Suffix after .* is appropriately applied
//Solution().isMatch("aabbbbbbbbbcc", "a.*d") == false
//Solution().isMatch("aabbbbbbbbbcc", "a.*") == true
//Solution().isMatch("aabbbbbbbbbcc", "a.b.*") == true
//
//// Malformed or empty patterns
//Solution().isMatch("a", "*") == false
//Solution().isMatch("a", "") == false
//
//// Multiple .* 0 or more wildcards
//Solution().isMatch("aaaabbbbddd", "a.*b.*d") == true
//Solution().isMatch("aaaabbbbddde", "a.*b.*d") == false


Solution().isMatch("aab", "c*a*b")





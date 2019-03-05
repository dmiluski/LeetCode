//: Playground - noun: a place where people can play

import UIKit

/*
 Problem 3

 Given a string, find the length of the longest substring without repeating characters.

 Examples:

 Given "abcabcbb", the answer is "abc", which the length is 3.

 Given "bbbbb", the answer is "b", with the length of 1.

 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

// Approach:
//  Iterate through the characters
//  Set<String> to identify unique characters
//
//
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {

        var longestString: String = ""
        var currentSubString: String = ""
        var set = Set<Character>()

        for char in s {

            // Identify Duplicate
            // Start Substring over with substring after initial duplicate
            if set.contains(char) {
                // Upate Substring
                let firstIndex = currentSubString.firstIndex(of: char)!
                let afterFirstInstance = currentSubString.index(after: firstIndex)
                currentSubString = String(currentSubString[afterFirstInstance...])

                // Update current set
                set = Set<Character>(currentSubString)
            }

            set.insert(char)
            currentSubString.append(char)

            if currentSubString.count > longestString.count {
                longestString = currentSubString
            }
        }
        return longestString.count
    }
}

// Tests
Solution().lengthOfLongestSubstring("abcabcbb") == 3 // "abc"
Solution().lengthOfLongestSubstring("bbbbb") == 1 // "b"
Solution().lengthOfLongestSubstring("pwwkew") == 3 // "wke"
Solution().lengthOfLongestSubstring("dvdf") == 3 // "vdf"

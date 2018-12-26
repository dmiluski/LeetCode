import Foundation

/*
 49. Group Anagrams

 Given an array of strings, group anagrams together.

 Example:

    Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
    Output:
    [
        ["ate","eat","tea"],
        ["nat","tan"],
        ["bat"]
    ]
 Note:

 All inputs will be in lowercase.
 The order of your output does not matter.
 */

/*
 Approach:
 1. How to determine anagrams:
        Sort String's Characters
 2. How to group? Dictionary(grouping:)
        Group first by sorted strings as grouping indicator
        Output
 */


class Solution {
    /**
     Groups anagram strings together

     - Parameters:
        - strs: Array of Strings to be grouped by anagrams

     - Returns:
        - Array of Array of Strings in groups of anagrams
    */
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        typealias Model = (sorted: String, original: String)

        // Determine anagrams by first sorting string instances
        let tuple = strs.map { (value) -> Model in
            return (sorted: String(value.sorted()), original: value)
        }

        // Group by sorted strings as key
        let groupedDictionaries = Dictionary(grouping: tuple, by: { $0.sorted })

        // Return Mapped Array of Arrays of Strings
        return groupedDictionaries.values.map { (array) -> [String] in
            return array.map({ $0.original })
        }
    }
}

// Tests:
let input = [
    "eat",
    "tea",
    "tan",
    "ate",
    "nat",
    "bat"]

let output = [
    ["ate","eat","tea"],
    ["nat","tan"],
    ["bat"]
]

print(Solution().groupAnagrams(input))

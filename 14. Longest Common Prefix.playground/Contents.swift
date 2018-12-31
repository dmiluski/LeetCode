import Foundation

/*
 14. Longest Common Prefix

 Write a function to find the longest common prefix string amongst an array of strings.

 If there is no common prefix, return an empty string "".

 Example 1:

 Input: ["flower","flow","flight"]
 Output: "fl"
 Example 2:

 Input: ["dog","racecar","car"]
 Output: ""
 Explanation: There is no common prefix among the input strings.
 Note:

 All given inputs are in lowercase letters a-z.
 */

extension Array where Element == String {
    // O(n)
    var shortestLength: Int {
        return reduce(first?.count ?? 0) { (result, element) -> Int in
            return Swift.min(result, element.count)
        }
    }
}

var foo = ["Hi", "How", "HARE"]
foo
    .compactMap({ $0.first })
    .allSatisfy { (character) -> Bool in
    guard let first = foo.first?.first else { return false }
    return character == first
}

class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {

        var longestPrefix = ""
        let arrayOfStringCharacters = strs.map(Array.init)


        // Iterate over an array of character arrays
        for index in 0..<strs.shortestLength {

            let initialCharacter = arrayOfStringCharacters[0][index]
            if arrayOfStringCharacters
                .map({ $0[index] })
                .allSatisfy({ (character) -> Bool in
                    return character == initialCharacter
                }) {
                longestPrefix.append(initialCharacter)
            } else {
                break

            }
        }




        return longestPrefix
    }
}

// Tests
Solution().longestCommonPrefix(["flower","flow","flight"]) == "fl"
Solution().longestCommonPrefix(["dog","racecar","car"]) == ""

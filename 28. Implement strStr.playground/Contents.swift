import Foundation

/*
28. Implement strStr()

 Implement strStr().

 Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

 Example 1:

 Input: haystack = "hello", needle = "ll"
 Output: 2
 Example 2:

 Input: haystack = "aaaaa", needle = "bba"
 Output: -1
 Clarification:

 What should we return when needle is an empty string? This is a great question to ask during an interview.

 For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().
 */

// Approach: Regular Expressions
struct Regex {

    // MARK: - Types

    typealias Match = (String, NSRange)

    // MARK: - Properties

    let pattern: String
    private let expression: NSRegularExpression

    // MARK: - Initialization

    init?(pattern: String) {
        guard let expression = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }

        self.pattern = pattern
        self.expression = expression
    }

    // MARK: - Matcher

    func matches(in string: String) -> [Match] {
        let nsString = string as NSString
        var matches: [Match] = []

        let range = NSRange(location: 0, length: nsString.length)
        expression.enumerateMatches(in: string, options: [], range: range) { (result, flags, stop) in
            if let result = result {
                let substring = nsString.substring(with: result.range)
                let match = (substring, result.range)
                matches.append(match)
            }
        }

        return matches
    }
}

class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        // Problem with this approach:
        // Special Characters could screw with Regex implementation
        let regex = Regex(pattern: needle)
        return regex?.matches(in: haystack).first?.1.location ?? -1
    }
}

// Approach using Solution (Currently implemented as Regex)
let input1 = ("hello", "ll")
Solution().strStr(input1.0, input1.1)

// Approach using collections range of:
let range = "hello".range(of: "ll", options: [])
range?.lowerBound.encodedOffset




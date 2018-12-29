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
extension String {
    func trimAdjacentAsterisks() -> String {
        var trimmedPattern: String = ""
        let characters = Array(self)
        for (index, character) in enumerated() {
            if index > 0,
                character == "*",
                characters[index - 1] == "*" {
                // Skip
            } else {
                trimmedPattern.append(character)
            }
        }
        return trimmedPattern
    }

    func nonWildCards() -> String {
        return filter({ $0 != "*" })
    }
}

// Notes:
// This solution works for items with few "*"
// For each "*", this recursive approach forks off several possible paths,
// quickly growing th enumber of possible attempts
//
// Although this worked fine fir 1600 / 1800 tests, the late LeetCode tests show this as being a problematic appraoch
//
// I attempted to optimize with smarter checks/sanitizations, but unfortunately those did not help the O(N!)
class RecursiveSolution {
    func isSanitizedPatternMatch(_ s: String, _ p: String) -> Bool {

        print("\(s), \(p)")
        let questionMark: Character = "?"
        let asterisk: Character = "*"

        switch (s.first, s.last, p.first, p.last) {
        case (nil, nil, nil, nil):
            // Sentinal Success Check
            return true

        case (_,_,_,_) where s == p:
            // Sentinal Success Check
            return true

        case (_?, _, nil, _):
            return false

        case (nil, _, asterisk, _):
            // Empty String Sequence Support
            let trimmedPattern = String(p.suffix(from: p.index(after: p.startIndex)))
            return isSanitizedPatternMatch(s, trimmedPattern)

        case (nil, _,questionMark, _):
            return false

        case (_?, _,questionMark, _):
            // Single Character Wild Card (Prefix)
            let trimmedString = String(s.suffix(from: s.index(after: s.startIndex)))
            let trimmedPattern = String(p.suffix(from: p.index(after: p.startIndex)))
            return isSanitizedPatternMatch(trimmedString, trimmedPattern)

        case (_, _?,_,questionMark):
            // Single Character Wild Card (Tail)
            let trimmedString = String(s.prefix(upTo: s.index(before: s.endIndex)))
            let trimmedPattern = String(p.prefix(upTo: p.index(before: p.endIndex)))
            return isSanitizedPatternMatch(trimmedString,trimmedPattern)

        case let (firstS?, _, firstP?, _) where firstS == firstP:
            // Matching Starting Character
            let trimmedString = String(s.suffix(from: s.index(after: s.startIndex)))
            let trimmedPattern = String(p.suffix(from: p.index(after: p.startIndex)))
            return isSanitizedPatternMatch(trimmedString, trimmedPattern)

        case let (firstS?, _, firstP?, _) where firstP != "*" && firstS != firstP:
            // Mismatched Starting Character
            return false

        case let (_, lastS?, _, lastP?) where lastS == lastP:
            // Matching Ending Character
            let trimmedString = String(s.prefix(upTo: s.index(before: s.endIndex)))
            let trimmedPattern = String(p.prefix(upTo: p.index(before: p.endIndex)))
            return isSanitizedPatternMatch(trimmedString, trimmedPattern)

        case let (_, lastS?, _, lastP?) where lastP != "*" && lastS != lastP:
            // Mismatched Ending Character
            return false

        case (_?, _?, asterisk, asterisk) where p.count > 1:
            // Pattern Contains * on beginning and end, in this case, first attempt to trim from both sides
            // This is problematic
            let trimmedStringPrefix = String(s.suffix(from: s.index(after: s.startIndex)))
            let trimmedStringSuffix = String(s.prefix(upTo: s.index(before: s.endIndex)))

            let trimmedPatternBothEnds = String(Array(p)[1..<p.count - 1])
            let trimmedPatternPrefix = String(p.suffix(from: p.index(after: p.startIndex)))
            let trimmedPatternSuffix = String(p.prefix(upTo: p.index(before: p.endIndex)))


            return
                // "*" No Use Edge Progression (Falls through to lower rule) (
                isSanitizedPatternMatch(s, trimmedPatternBothEnds) ||
                isSanitizedPatternMatch(s, trimmedPatternPrefix) ||
                isSanitizedPatternMatch(s, trimmedPatternSuffix) ||


                // Single Use Progression
                isSanitizedPatternMatch(trimmedStringPrefix, trimmedPatternPrefix) ||
                isSanitizedPatternMatch(trimmedStringSuffix, trimmedPatternSuffix) ||

                // Sequence Use Progression
                (s.count > p.filter({ $0 != asterisk }).count && isSanitizedPatternMatch(trimmedStringPrefix, p)) ||
                (s.count > p.filter({ $0 != asterisk }).count && isSanitizedPatternMatch(trimmedStringSuffix, p))


        case (_, _, asterisk, _):
            // Cases:
            // 1. Empty Sequence (ignore *)
            // 2. Singe Char (1 to 1 string to pattern relationship)
            // 3. Sequence (Apply pattern character to the next suffix
            let trimmedString = s.isEmpty ? s : String(s.suffix(from: s.index(after: s.startIndex)))
            let trimmedPattern = String(p.suffix(from: p.index(after: p.startIndex)))

            return isSanitizedPatternMatch(s, trimmedPattern) ||
                isSanitizedPatternMatch(trimmedString, trimmedPattern) ||
                (s.count > p.filter({ $0 != asterisk }).count && isSanitizedPatternMatch(trimmedString, p))

        default:
            return false
        }
    }

    func isMatch(_ s: String, _ p: String) -> Bool {
        // First Sanitize input, given the rules of a wildcard '*', having adjacent '*' severse no purpose
        let sanitizedPattern = p.trimAdjacentAsterisks()
        return isSanitizedPatternMatch(s, sanitizedPattern)
    }
}

// Reference: https://www.cnblogs.com/strengthen/p/9907424.html
// Dynamic Programming:
// This was a learning lesson in Linear vs Factorial (Due to * possibilities)
//
// Although dynamic programming does not come as natural to me as recursion,
// this is something I need to practice to build into a better muscle memory option

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {

        var stringIndex = 0
        var patternIndex = 0
        var match = 0
        var asteriskIndex = -1

        let sCharacters = Array(s)
        let sCount = sCharacters.count
        let pCharacters = Array(p)
        let pCount = pCharacters.count


        let questionMark: Character = "?"
        let asterisk: Character = "*"

        // Iterate Through String's Characters
        while stringIndex < sCount {

            // Check for ? or matching character
            if patternIndex < pCount &&
                (pCharacters[patternIndex] == questionMark ||
                pCharacters[patternIndex] == sCharacters[stringIndex]) {

                stringIndex += 1
                patternIndex += 1

            }
            // Check for "*", Skip to next patternIndex for now retaining a reference to asterisk
            else if patternIndex < pCount && pCharacters[patternIndex] == asterisk {

                asteriskIndex = patternIndex
                match = stringIndex
                patternIndex += 1

            }
            // If we have a stashed asterisk and don't satisfy events above
            // retry with element after
            else if asteriskIndex != -1 {

                patternIndex = asteriskIndex + 1
                match += 1
                stringIndex = match

            } else {
                return false
            }
        }

        // Given stringIndex is now empty,
        // allow remaining edge asterisks to be included as no-op pattern items
        while patternIndex < pCount && pCharacters[patternIndex] == asterisk {
            patternIndex += 1
        }

        return patternIndex == pCount
    }
}

// Tests
Solution().isMatch("aa", "a") == false
Solution().isMatch("aa", "*") == true
Solution().isMatch("cb", "?a") == false
Solution().isMatch("adceb", "*a*b") == true
Solution().isMatch("acdcb", "a*c?b") == false

//// Tests with Empty Sequence
Solution().isMatch("", "*") == true
Solution().isMatch("a", "a*") == true
Solution().isMatch("a", "a*b") == false


// Complex LeetCode Lengthier Test Cases
// Because of the length, these tests expose postential processing scalling issues for non-linear appraoches
Solution().isMatch("babaaababaabababbbbbbaabaabbabababbaababbaaabbbaaab", "***bba**a*bbba**aab**b") == false
Solution().isMatch("bbbbbbbabbaabbabbbbaaabbabbabaaabbababbbabbbabaaabaab", "b*b*ab**ba*b**b***bba") == false
Solution().isMatch("bbaaaaaabbbbbabbabbaabbbbababaaabaabbababbbabbababbaba", "b*b*ba**a*aaa*a*b**bbaa") == false
Solution().isMatch("d", "*d*d") == false
Solution().isMatch("b", "*?*?*") == false
Solution().isMatch("bbaabbbabbbbabbbaaabababbbabbababbbabaaabbbbaabaabaaaa", "*b**b*a**abbaab*aba***") == false

//RecursiveSolution().isMatch("babaaababaabababbbbbbaabaabbabababbaababbaaabbbaaab", "***bba**a*bbba**aab**b") == false
//RecursiveSolution().isMatch("bbbbbbbabbaabbabbbbaaabbabbabaaabbababbbabbbabaaabaab", "b*b*ab**ba*b**b***bba") == false
//RecursiveSolution().isMatch("bbaaaaaabbbbbabbabbaabbbbababaaabaabbababbbabbababbaba", "b*b*ba**a*aaa*a*b**bbaa") == false
RecursiveSolution().isMatch("d", "*d*d") == false
RecursiveSolution().isMatch("b", "*?*?*") == false
//RecursiveSolution().isMatch("bbaabbbabbbbabbbaaabababbbabbababbbabaaabbbbaabaabaaaa", "*b**b*a**abbaab*aba***") == false

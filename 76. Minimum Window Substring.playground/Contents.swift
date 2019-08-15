import Foundation
/*
 76. Minimum Window Substring
 Hard

 Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).

 Example:

 Input: S = "ADOBECODEBANC", T = "ABC"
 Output: "BANC"
 Note:

 If there is no such window in S that covers all characters in T, return the empty string "".
 If there is such window, you are guaranteed that there will always be only one unique minimum window in S.
 */

class Solution {

    // Approach:
    // Given the hint O(n), look to iterate left to right and keep track of left index/rightIndex
    // Why this is a bit harder is the fact we have a dynamic *T* input
    //
    // Original
    func minWindow(_ s: String, _ t: String) -> String {

        // Bad Input Check: Non-Matching Set to String
        guard s.count >= t.count else {
            return ""
        }

        // Ensure All characters are accounted for in the string
        // No Such Window Check
        // This may not be necessary
        let tCharacterSet = CharacterSet(charactersIn: t)
        guard CharacterSet(charactersIn: s).isSubset(of: tCharacterSet) else { return "" }

//        let ranges = t.compactMap { (character) -> Range<String.Index>? in
//            return s.rangeOfCharacter(from: CharacterSet(charactersIn: String(character)))
//        }
//        guard ranges.count == t.count else {
//            return ""
//        }


        // Construct Dictionary of Indexes for each t character
        //
        var indexModel: [Character: Int] = {
            var dictionary = [Character: Int]()

            // Set default count, or update in the instance character is duplicated
            t.forEach({
                dictionary[$0] = (dictionary[$0] ?? 0) + 1 }
            )
            return dictionary
        }()

        // Running Substring
        var minimumWindowSubstring = ""
        var runningSubstring = ""

        // Begin with a window of size *t.count*
//        var windowSize = t.count



        // Iterate


        // Found Satisfactory Substring?

        return ""
    }
}

//let characterSet = CharacterSet(charactersIn: "T")
//let range = "ADOBECODEBANC".rangeOfCharacter(from: characterSet)
//"ADOBECODEBANC".rangeOfCharacter(from: characterSet)
//range
Solution().minWindow("ADOBECODEBANC", "ABCQ")

let inputString = "ADOBECODEBANC"
let foo = CharacterSet(charactersIn: "ADOBECODEBANC")
let bar = CharacterSet(charactersIn: "ABCT")
let output = foo.intersection(bar)
output.bitmapRepresentation
output.debugDescription
output.description

// Tools available:
//CharacterSet

bar.isStrictSubset(of: foo)
bar.isSubset(of: foo)
foo.isSubset(of: bar)

CharacterSet(String(Array(inputString)[0...3]))

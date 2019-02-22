import Foundation

/*
 58. Length of Last Word

 Given a string s consists of upper/lower-case alphabets and empty space characters ' ', return the length of last word in the string.

 If the last word does not exist, return 0.

 Note: A word is defined as a character sequence consists of non-space characters only.

 Example:

 Input: "Hello World"
 Output: 5
 */

class SolutionInternational {

    // Internatially Friendly Solution
    func lengthOfLastWord(_ s: String) -> Int {

        // Initial Default Count
        var lengthOfLastWord = 0

        // Enumerate by Words (Reversed)
        // By using enumerate by words we play friendly with interantional
        // Word formations
        s.enumerateSubstrings(in: s.startIndex..<s.endIndex,
                              options: [.byWords,
                                        .reverse])
        { (substring, substringRange, enclosingRange, stop) in

            if let count = substring?.count {
                lengthOfLastWord = count
            }

            // Upon finding first word length, stop
            stop = true
        }

        return lengthOfLastWord
    }
}

class Solution {

    // Internatially Friendly Solution
    func lengthOfLastWord(_ s: String) -> Int {

        // Initial Default Count
        var lengthOfLastWord = 0

        for character in s.reversed() {

            // Allow Breakout of Loop
            var shouldBreak = false

            // Allow trailin spaces
            switch (lengthOfLastWord, character == " ") {
            case (0, true):
                continue
            case (1..., true):
                shouldBreak = true
            case(_, false):
                lengthOfLastWord += 1
                continue
            case (_, true):
                // Should never see a Negative Value
                fatalError()
            }

            // Break out of loop
            if shouldBreak {
                break
            }
        }
        return lengthOfLastWord
    }
}
Solution().lengthOfLastWord("Hello World") == 5
Solution().lengthOfLastWord("Hi Son") == 3
Solution().lengthOfLastWord("a ") == 1


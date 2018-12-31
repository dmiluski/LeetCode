import Foundation

/*

 Implement atoi which converts a string to an integer.

 The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

 The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

 If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

 If no valid conversion could be performed, a zero value is returned.

 Note:

 Only the space character ' ' is considered as whitespace character.
 Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. If the numerical value is out of the range of representable values, INT_MAX (231 − 1) or INT_MIN (−231) is returned.

    Example 1:

        Input: "42"
        Output: 42

    Example 2:
        Input: "   -42"
        Output: -42

        Explanation: The first non-whitespace character is '-', which is the minus sign.
        Then take as many numerical digits as possible, which gets 42.
    Example 3:

        Input: "4193 with words"
        Output: 4193

        Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.
    Example 4:

        Input: "words and 987"
        Output: 0

        Explanation: The first non-whitespace character is 'w', which is not a numerical
        digit or a +/- sign. Therefore no valid conversion could be performed.

    Example 5:

        Input: "-91283472332"
        Output: -2147483648

        Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer.
        Thefore INT_MIN (−231) is returned.
 */
// Approach 3
//  Extract Individual Int numbers into array and compare across indexes
//  Similar to the Int work with Powers


extension CharacterSet {
    // Any of these characters can initiate the beginning of a number
    static let initialIntCharacterCharacterSet = CharacterSet(charactersIn: "-+0123456789")
}

extension Int {
    // Power Helper
    // - At some magnitudes this is not viable due to precision
    func toThe(_ x: Int) -> Double {
        return pow(Double(self), Double(x))
    }
}

class Solution {

    // Tasks:
    // Parse Characters
    //  Ensure Only Decimal Characters

    // Returns:
    //  Array of Valid integers based on characters until invalid character is found
    //  Strips beginning zeros since those don't are unnecessary for calculating Int Values
    func extractDecimalCharacters(_ string: String) -> [Int] {

        // Map String Characters to individual Ints
        let characters = Array(string)
        var result: [Int] = []

        for character in characters {
            guard let value = Int(String(character)) else { break }
            result.append(value)
        }

        // Strip leading Zeros
        var index = 0
        while index < result.count {
            if result[index] == 0 {
                index += 1
            } else {
                break
            }
        }

        return Array(result[index..<result.count])
    }

    func myAtoi(_ str: String) -> Int {

        // First trim whitespace from edges
        let string = str.trimmingCharacters(in: .whitespacesAndNewlines)

        // Identify first item satisfies requirements Digits + "-"
        guard let first = string.first,
            CharacterSet.initialIntCharacterCharacterSet.contains(first.unicodeScalars.first!) else { return 0 }

        let isNegative: Bool
        let arrayOfIntegers: [Int]

        // Determine Sign, then Extract Satisfactory Decimal Characters
        switch first {
        case "-":
            // Strip Char, Mark negative, Parse Suffix
            isNegative = true
            arrayOfIntegers = extractDecimalCharacters(
                String(string.suffix(from: string.index(after: string.startIndex)))
            )
        case "+":
            // Strip Char, Mark Positive, Parse Suffix
            isNegative = false
            arrayOfIntegers = extractDecimalCharacters(
                String(string.suffix(from: string.index(after: string.startIndex)))
            )
        default:
            // Strip Char, Mark Positive, Parse Suffix
            isNegative = false
            arrayOfIntegers = extractDecimalCharacters(string)
            // Parse out rest of content until end or invalid character
        }

        // Construct Int
        var sum: Double = 0
        for (index, value) in arrayOfIntegers.reversed().enumerated() {
            let addedValue = Double(value) * 10.toThe(index)
            sum += addedValue
        }

        if isNegative {
            sum = sum * -1
        }

        // Guard against Out of Int32 Boundaries (Default to responses)
        if sum > Double(Int32.max) {
            return Int(Int32.max)
        } else if sum < Double(Int32.min) {
            return Int(Int32.min)
        } else {
            return Int(sum)
        }
    }
}

Solution().myAtoi("42") == 42
Solution().myAtoi("    -42") == -42
Solution().myAtoi("4193 with words") == 4193
Solution().myAtoi("words an 987") == 0
Solution().myAtoi("-91283472332") == -2147483648
Solution().myAtoi("-000000000000000000000000000000000000000000000000001")
Solution().myAtoi("20000000000000000000")

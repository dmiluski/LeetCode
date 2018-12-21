//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 12. Integer to Roman

 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000

 For example, two is written as II in Roman numeral, just two one's added together. Twelve is written as, XII, which is simply X + II. The number twenty seven is written as XXVII, which is XX + V + II.

 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

 I can be placed before V (5) and X (10) to make 4 and 9.
 X can be placed before L (50) and C (100) to make 40 and 90.
 C can be placed before D (500) and M (1000) to make 400 and 900.
 Given an integer, convert it to a roman numeral. Input is guaranteed to be within the range from 1 to 3999.
 */

enum RomanNumeralChar: String {
    case I
    case IV // Special
    case V
    case IX
    case X
    case XL
    case L
    case XC
    case C
    case CD
    case D
    case CM
    case M

    var intValue: Int {
        switch self {
        case .I: return 1
        case .IV: return 4
        case .V: return 5
        case .IX: return 9
        case .X: return 10
        case .XL: return 40
        case .L: return 50
        case .XC: return 90
        case .C: return 100
        case .CD: return 400
        case .D: return 500
        case .CM: return 900
        case .M: return 1000
        }
    }

    // In increasing Values
    static var allValues: [RomanNumeralChar] = {
        return [.I, .IV, .V, .IX, .X, .XL, .L, .XC, .C, .CD, .D, .CM, .M]
    }()
}

class Solution {
    func intToRoman(_ num: Int) -> String {
        var remainder = num
        var output = ""
        let options = RomanNumeralChar.allValues.reversed()
        options.forEach { (option) in
            let count = remainder / option.intValue
            let newRemainder = remainder % option.intValue
            output.append(String(repeating: option.rawValue, count: count))
            remainder = newRemainder
        }
        return output
    }
}

// Tests
Solution().intToRoman(3) == "III"
Solution().intToRoman(4) == "IV"
Solution().intToRoman(9) == "IX"
Solution().intToRoman(58) == "LVIII" // C = 100, L = 50, XXX = 30 and III = 3
Solution().intToRoman(1994) == "MCMXCIV" // M = 1000, CM = 900, XC = 90 and IV = 4

/*
 13. Roman to Integer

 Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.
*/
class Solution2 {
    func romanToInt(_ s: String) -> Int {
        var input = s
        var output = 0

        // Parse String perfix to output int value
        let options = RomanNumeralChar.allValues.reversed()

        // Loop through until input is empty
        while !input.isEmpty {
            for (_, option) in options.enumerated() {
                // Sample 2 Options:
                //  Option 1: 2 Chars (for special character possibility)
                //  Option 2: 1 Char for normal characters
                let prefixes = [String(input.prefix(2)), String(input.prefix(1))]

                guard let romanNumeral = prefixes
                    .lazy
                    .compactMap(RomanNumeralChar.init)
                    .first else { continue }

                input = String(input.dropFirst(romanNumeral.rawValue.count))
                output += romanNumeral.intValue

                // Break out of enumeration to re-run with a new sample off of the input
                // No need to Step through RomanNumerals
                break
            }

        }
        return output
    }
}

// Tests
Solution2().romanToInt("III") == 3
Solution2().romanToInt("IV") == 4
Solution2().romanToInt("IX") == 9
Solution2().romanToInt("LVIII") == 58 // C = 100, L = 50, XXX = 30 and III = 3
Solution2().romanToInt("MCMXCIV") == 1994 // M = 1000, CM = 900, XC = 90 and IV = 4

//: Playground - noun: a place where people can play

import UIKit

enum RomanNumeralChar: String, CaseIterable {
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

/*
 13. Roman to Integer

 Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.
*/
class Solution {
    func romanToInt(_ s: String) -> Int {
        var input = s
        var output = 0

        // Parse String perfix to output int value
        let options = RomanNumeralChar.allValues.reversed()

        // Loop through until input is empty
        while !input.isEmpty {
            for (_, _) in options.enumerated() {
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
Solution().romanToInt("III") == 3
Solution().romanToInt("IV") == 4
Solution().romanToInt("IX") == 9
Solution().romanToInt("LVIII") == 58 // C = 100, L = 50, XXX = 30 and III = 3
Solution().romanToInt("MCMXCIV") == 1994 // M = 1000, CM = 900, XC = 90 and IV = 4

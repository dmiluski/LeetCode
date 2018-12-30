//: Playground - noun: a place where people can play

import Foundation


/*
 17. Letter Combinations of a Phone Number

 Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.

 A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.



 Example:

 Input: "23"
 Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
 Note:

 Although the above answer is in lexicographical order, your answer could be in any order you want.
 */

/*
 PhoneNumPad

 Model provindg mapping between Phone Number Pad Buttons to backing alphabetical values
 */
enum PhoneNumPad: Character {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"

    var alphabeticalValues: [String] {
        switch self {
        case .zero: return []
        case .one: return []
        case .two: return ["a","b","c"]
        case .three: return ["d","e","f"]
        case .four: return ["g","h","i"]
        case .five: return ["j","k","l"]
        case .six: return ["m","n","o"]
        case .seven: return ["p","q","r","s"]
        case .eight: return ["t","u","v"]
        case .nine: return ["w","x","y","z"]
        }
    }
}

extension CharacterSet {
    public static var numPadNumerals = CharacterSet(charactersIn: "23456789")
    public static var fullNumPadNumerals = CharacterSet(charactersIn: "0123456789")
}

/*
 Solution 1:

 Recursively step through options

 Given final alpha character mappings, append options to priors variants
 Time: O(m*n) where n is the number of characters, and m is the average item per character
 Space:O(n) Accounting for output array where n is the number of characters, and m is the average item per character
 */
class Solution {
    func recurseletterCombinations(_ digits: String) -> [String]? {
        // Data Sanatization (Only Allow Digits)
        // TODO: Consider Throwable approach
        // Option: Strip digits outside of acceptablerange?
        guard digits.rangeOfCharacter(from: CharacterSet.numPadNumerals.inverted) == nil else {
            return nil
        }

        // Sentinal - Check if empty?
        guard let first = digits.first else {
            return nil
        }

        // Range Check (Alternative Handling Options Possible
        guard let numPadItem = PhoneNumPad(rawValue: first) else {
            let suffix = String(digits.suffix(from: digits.index(after: digits.startIndex)))
            return recurseletterCombinations(suffix)
        }

        // Sentinal - Last Permutation
        guard let permutations = recurseletterCombinations(String(digits.suffix(from: digits.index(after: digits.startIndex)))) else {
            return numPadItem.alphabeticalValues
        }

        // Build Output Array
        var output: [String] = []
        numPadItem.alphabeticalValues.forEach { (prefix) in
            permutations.forEach({ (value) in
                output.append(prefix + value)
            })
        }
        return output

    }

    func letterCombinations(_ digits: String) -> [String] {
        return recurseletterCombinations(digits) ?? []
    }
}


// Tests
Solution().letterCombinations("23") == ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
Solution().letterCombinations("23").count
//Solution().letterCombinations("22222")



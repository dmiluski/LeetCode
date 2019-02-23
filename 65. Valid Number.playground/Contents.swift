import Foundation

/*
 65. Valid Number

 Some examples:
 "0" => true
 " 0.1 " => true
 "abc" => false
 "1 a" => false
 "2e10" => true
 " -90e3   " => true
 " 1e" => false
 "e3" => false
 " 6e-1" => true
 " 99e2.5 " => false
 "53.5e93" => true
 " --6 " => false
 "-+3" => false
 "95a54e53" => false

 Note: It is intended for the problem statement to be ambiguous. You should gather all requirements up front before implementing one. However, here is a list of characters that can be in a valid decimal number:

 Numbers 0-9
 Exponent - "e"
 Positive/negative sign - "+"/"-"
 Decimal point - "."
 Of course, the context of these characters also matters in the input.
 */

extension CharacterSet {
    // Any of these characters can initiate the beginning of a number
    static let initialIntCharacterCharacterSet = CharacterSet(charactersIn: "-+0123456789")
    static let initialDoubleCharacterCharacterSet = CharacterSet(charactersIn: ".-+0123456789")
}

class Solution {

    // Tasks:
    // Parse Characters
    //  Ensure Only Decimal Characters

    // Returns:
    //  Array of Valid integers based on characters until invalid character is found
    private func isIntSanExponent(_ string: String) -> Bool {
        guard !string.isEmpty else { return false }

        // Validate Number Satisfies character limits
        guard string.rangeOfCharacter(from: CharacterSet.initialIntCharacterCharacterSet.inverted) == nil else {
            return false
        }


        // Identify first item satisfies requirements Digits + "-"
        guard let first = string.first else { return false }

        // Counts
        let plusCount = string.filter({ $0 == "+" }).count
        let negativeCount = string.filter({ $0 == "-" }).count

        // Verify Special Character Valid Counts
        guard plusCount <= 1,
            negativeCount <= 1,
            plusCount + negativeCount <= 1 else { return false }

        // Check Special Character location/count
        switch (first, plusCount, negativeCount) {
        case ("-",0,1):
            return true
        case (_,_,1):
            return false
        case ("+",1,0):
            return true
        case (_,1,_):
            return false
        default:
            return true
        }

    }
    private func isDoubleSansExponent(_ string: String) -> Bool {
        guard !string.isEmpty else { return false }

        // Validate Number Satisfies character limits
        guard string.rangeOfCharacter(from: CharacterSet.initialDoubleCharacterCharacterSet.inverted) == nil else {
            return false
        }

        
        // Identify first item satisfies requirements Digits + "-"
        guard let first = string.first else { return false }

        // Counts
        let plusCount = string.filter({ $0 == "+" }).count
        let negativeCount = string.filter({ $0 == "-" }).count
        let decimalCount = string.filter({ $0 == "."}).count

        // Verify Special Character Valid Counts
        guard plusCount <= 1,
            negativeCount <= 1,
            decimalCount <= 1,
            plusCount + negativeCount <= 1 else { return false }

        // If a decimal exists, and first item is nil Decimal must have value to the right of it
        // A decimal may exist after first bucket if specified
        if decimalCount > 0 {
            let decimalBuckets = string
                .split(separator: ".", maxSplits: Int.max, omittingEmptySubsequences: false)

            switch (decimalBuckets[0].count, decimalBuckets[1].count) {
            case (0, 1...):
                return true
            case (1..., 0):
                return true
            case (0, 0):
                return false
            default:
                return true
            }
        }

        // Check Special Character location/count
        switch (first, plusCount, negativeCount) {
        case ("-",0,1):
            return true
        case (_,_,1):
            return false
        case ("+",1,0):
            return true
        case (_,1,_):
            return false
        default:
            return true
        }
    }

    // Given we don't need to output number
    // We only need to verify rules
    //
    // Approach:
    // Break into two parts. A number is valid if it's a valid double left/right of e
    //
    // - exponents (single e with values to the right)
    func isNumber(_ s: String) -> Bool {

        // Play friendly with surrounding whitespace
        let string = s.trimmingCharacters(in: CharacterSet.whitespaces)

        guard string.filter({ $0 == "e" })
            .count <= 1 else {
            return false
        }

        // Validate items to the left/right of "e"
        let buckets = string
            .split(separator: "e", maxSplits: Int.max, omittingEmptySubsequences: false)
             .map(String.init)

        // We may get 1 vs 2 buckets
        switch buckets.count {
        case 1:
            return isDoubleSansExponent(buckets[0])
        case 2:
            return isDoubleSansExponent(buckets[0]) && isIntSanExponent(buckets[1])
        default:
            fatalError()
        }
    }
}

Solution().isNumber("0") == true
Solution().isNumber("0.1") == true
Solution().isNumber("abc") == false
Solution().isNumber("2e10") == true
Solution().isNumber("-90e3") == true
Solution().isNumber("1e") == false
Solution().isNumber("e3") == false
Solution().isNumber("6e-1") == true

// Question? Is e value need to be Integer?
Solution().isNumber("99e2.5") == false
Solution().isNumber("55.5e93") == true
Solution().isNumber("--6") == false
Solution().isNumber("-+3") == false
Solution().isNumber("95a54e53") == false
Solution().isNumber("0") == true
Solution().isNumber(".") == false
Solution().isNumber("1 ") == true
Solution().isNumber("3.") == true
Solution().isNumber(".5") == true

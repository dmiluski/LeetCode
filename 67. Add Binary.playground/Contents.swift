import Foundation

/*
 67. Add Binary

 Given two binary strings, return their sum (also a binary string).

 The input strings are both non-empty and contains only characters 1 or 0.

 Example 1:

 Input: a = "11", b = "1"
 Output: "100"
 Example 2:

 Input: a = "1010", b = "1011"
 Output: "10101"
 */




class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        let binaryCharacterSet = CharacterSet(charactersIn: "01")
        guard a.rangeOfCharacter(from: binaryCharacterSet.inverted) == nil,
            b.rangeOfCharacter(from: binaryCharacterSet.inverted) == nil else {
                return "Invalid Entry"
        }

        let startingValue = Int(("0" as UnicodeScalar).value)
        let aInts: [Int] = a.compactMap({
            guard let first = $0.unicodeScalars.first else { return nil }
            return Int(first.value) - startingValue
        })
        let bInts: [Int] = b.compactMap({
            guard let first = $0.unicodeScalars.first else { return nil }
            return Int(first.value) - startingValue
        })

        var buffer = ""
        var itaratorA = aInts.reversed().makeIterator()
        var iteratorB = bInts.reversed().makeIterator()
        var carry = 0

        var itemA = itaratorA.next()
        var itemB = iteratorB.next()

        repeat {
            switch (itemA, itemB) {
            case let (itemA?, itemB?):

                // Calculate value
                let sum = itemA + itemB + carry
                carry = sum / 2

                // Append new value
                buffer.append(String(sum % 2))
            case (nil, let itemB?):
                // Calculate value
                let sum = itemB + carry
                carry = sum / 2

                // Append new value
                buffer.append(String(sum % 2))
            case (let itemA?, nil):
                // Calculate value
                let sum = itemA + carry
                carry = sum / 2

                // Append new value
                buffer.append(String(sum % 2))
            case (nil, nil):
                break
            }

            itemA = itaratorA.next()
            itemB = iteratorB.next()

        } while itemA != nil || itemB != nil

        // Consider of last carry
        if carry > 0 {
            buffer.append(String(carry))
        }
        // Custruct Expected Output
        return String(buffer.reversed())
    }
}

Solution().addBinary("1", "11")
Solution().addBinary("11", "1") == "100"
Solution().addBinary("1010", "1011") == "10101"
Solution().addBinary("000", "111") == "111"


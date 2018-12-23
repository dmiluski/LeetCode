import Foundation

/*
 43. Multiply Strings

 Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

 Example 1:

 Input: num1 = "2", num2 = "3"
 Output: "6"
 Example 2:

 Input: num1 = "123", num2 = "456"
 Output: "56088"
 Note:

 The length of both num1 and num2 is < 110.
 Both num1 and num2 contain only digits 0-9.
 Both num1 and num2 do not contain any leading zero, except the number 0 itself.
 You must not use any built-in BigInteger library or convert the inputs to integer directly.
 */

/*
 Approach:
 Given I can multiply Two integers to get an output, I can convert the string to Integer, then multiply

 Given Prior effor in (38. Count and Say), use Extensions to extract String Characters to an array of integers
 Then construct the Integer


*/

extension Int {
    /// Returns Current Int as an array of it's individual decimal characters
    //  eg. 1234 -> [1,2,3,4]
    //  eg  1    -> [1]
    //  eg  0    -> []
    //
    // Currently only support Positive Numbers
    func toArray() -> [Int] {
        var remainder = self
        var array: [Int] = []

        while remainder > 0 {
            array.append(remainder % 10)
            remainder = remainder / 10
        }
        return Array(array.reversed())
    }
}

extension String {
    // Extracts Integer characters to an array
    func toIntArray() -> [Int] {
        var array: [Int] = []

        for character in Array(self) {
            if let value = Int(String(character)) {
                array.append(Int(value))
            }
        }
        return array
    }
}

extension Array where Element == Int {
    func toInteger() -> Int {
        var sum: Int = 0
        for (index, value) in self.reversed().enumerated() {
            sum += Int(Double(value) * pow(Double(10), Double(index)))
        }
        return sum
    }
}

class Solution {

    // Using Integer Multiplication (Limited by 64bit Int Limit)
    // So this is incompatible with the requirements of the question
    func intMultiply(_ num1: String, _ num2: String) -> String {
        let output = num1.toIntArray().toInteger() * num2.toIntArray().toInteger()
        return output.toArray()
            .map(String.init)
            .joined()
    }

    // Borrowed from ( 37. Sudoku Solver)

    // This should function, but doesn't perform great due to the square number of calculations
    // Performance (O(n^2))
    func multiply(_ num1: String, _ num2: String) -> String {

        // Holy Moly
        // Its been so long since I did Multiplication

        // Create Array to Store Long Multiplication Steps
        // Include Space for Carry
        let num1Characters = Array(num1)
        let num2Characters = Array(num2)

        let num1Count = num1Characters.count
        let num2Count = num2Characters.count

        // Sequence with Character + Location(in grid)
        // Sequence contains (character + Offset from initial character)
        // This will be useful when finding the digit index to work with
        let sequence1 = zip(num1Characters, 0..<num1Count).reversed()
        let sequence2 = zip(num2Characters, 0..<num2Count).reversed()

        // Summation Storage
        // By storying in a single Flat Array, we can carry a digits without
        // requiring sequeces to have that index. This saved space/allocations vs initial grid approach
        // We can assume any product length will be <= sum of character counts
        var digits = Array(repeating: 0, count: num1Count + num2Count)

        for (character1, index1) in sequence1 {
            for (character2, index2) in sequence2 {
                // Assume Int Character
                let product = Int(String(character1))! * Int(String(character2))!

                let carryPosition = index1 + index2
                let position = carryPosition + 1
                let sum = product + digits[position]

                digits[carryPosition] += sum / 10;
                digits[position] = sum % 10;
                print(position)
                print(digits)
                print()
            }
        }
        var output = digits
            .map(String.init)
            .joined()

        // Trim Extra Prefix "0"s
        while output.first == "0", output.count > 1 {
            output.removeFirst()
        }

        return output
    }
}


// Tests
Solution().multiply("2", "3") == "6"
Solution().multiply("123", "456") == "56088"
Solution().multiply("12", "12") == "144"
Solution().multiply("2", "2") == "4"
Solution().multiply("111111111", "111111111") == "12345678987654321"
Solution().multiply("111", "111")

// Big numbers
// 96 Character Multiplication
Solution().multiply("111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111", "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111") == "12345679012345679012345679012345679012345679012345679012345679012345679012345679012345679012345654320987654320987654320987654320987654320987654320987654320987654320987654320987654320987654321"

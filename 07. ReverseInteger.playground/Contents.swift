//: Playground - noun: a place where people can play

import UIKit


/*
 Problem 7: Reverse Integer

 Given a 32-bit signed integer, reverse digits of an integer.

 Example 1:

 Input: 123
 Output: 321
 Example 2:

 Input: -123
 Output: -321
 Example 3:

 Input: 120
 Output: 21
 */

class Solution {
    func reverse(_ x: Int) -> Int {

        let isNegative = x < 0
        var absoluteValue = abs(x)
        var values: [Int] = []

        // Extract Digits to array
        while absoluteValue > 0 {
            let remainder = absoluteValue % 10
            print(remainder)
            values.append(remainder)
            absoluteValue = absoluteValue / 10
        }

        // Add Back Up by Power
        var sum = 0
        for (index, value) in values.reversed().enumerated() {
            sum = sum + (value * Int(pow(Double(10), Double(index))))
        }

        if isNegative {
            sum = sum * -1
        }

        // Guard against Out of Int32 Boundaries (Default to 0)
        if sum > Int(Int32.max) || sum < Int(Int32.min) {
            return 0
        }

        return sum
    }
}

// Tests
Solution().reverse(123) == 321
Solution().reverse(-123) == -321
Solution().reverse(120) == 21

import Foundation

/*
 69. Sqrt(x)
 Easy

 Implement int sqrt(int x).

 Compute and return the square root of x, where x is guaranteed to be a non-negative integer.

 Since the return type is an integer, the decimal digits are truncated and only the integer part of the result is returned.

 Example 1:

    Input: 4
    Output: 2
    Example 2:

    Input: 8
    Output: 2
    Explanation: The square root of 8 is 2.82842..., and since
    the decimal part is truncated, 2 is returned.
 */




class Solution {
    // Returns Int truncated Calculated Square Route
    func mySqrt(_ x: Int) -> Int {
        guard x != 0 else { return 0}

        // Starting with 2, grow until passing input
        // Given Square's growth, this leads to a log(n) completion time
        var temp = 1
        var foundRoot = false

        // Loop until we  pass input (x)
        while !foundRoot {

            let square = temp * temp
            if square == x {
                foundRoot = true
            } else if square > x {
                foundRoot = true
                temp -= 1
            } else {
                temp += 1
            }
        }

        return temp
    }
}

// Tests
Solution().mySqrt(4) == 2
Solution().mySqrt(4)
// The square root of 8 is 2.82842..., and since the decimal part is truncated, 2 is returned.
Solution().mySqrt(8) == 2

Int(9.11)

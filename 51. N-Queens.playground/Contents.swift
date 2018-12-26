import Foundation
import Accelerate
/*
 51. N-Queens

 The n-queens puzzle is the problem of placing n queens on an n×n chessboard such that no two queens attack each other.



 Given an integer n, return all distinct solutions to the n-queens puzzle.

 Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space respectively.

 Example:

 Input: 4
 Output: [
 [".Q..",  // Solution 1
 "...Q",
 "Q...",
 "..Q."],

 ["..Q.",  // Solution 2
 "Q...",
 "...Q",
 ".Q.."]
 ]
 Explanation: There exist two distinct solutions to the 4-queens puzzle as shown above.
 */


class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        return pow(x, Double(n))
    }
}

// Tests
Solution().myPow(2, 10) == 1024
Solution().myPow(2.1, 3) == 9.261000000000001
Solution().myPow(2, -2) == 0.25

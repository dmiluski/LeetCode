import Foundation

/*
 120. Triangle
 Medium

 Given a triangle, find the minimum path sum from top to bottom. Each step you may move to adjacent numbers on the row below.

 For example, given the following triangle

 [
 [2],
 [3,4],
 [6,5,7],
 [4,1,8,3]
 ]
 The minimum path sum from top to bottom is 11 (i.e., 2 + 3 + 5 + 1 = 11).

 Note:

 Bonus point if you are able to do this using only O(n) extra space, where n is the total number of rows in the triangle.
 */

class Solution {
//    /// Misunderstanding of the problem :face_palm
//    /// Requires to only offer adjacent
//    func minimumTotal(_ triangle: [[Int]]) -> Int {
//        var sum = 0
//        triangle.forEach { (array) in
//            return sum += array.min() ?? 0
//        }
//        return sum
//    }

    func minimumTotal(_ triangle: [[Int]]) -> Int {
        return 0
    }
}

let input1 = [
    [2],
    [3,4],
    [6,5,7],
    [4,1,8,3]
]

let input2 = [[-1],[2,3],[1,-1,-3]]

Solution().minimumTotal(input1) == 11
Solution().minimumTotal(input2) == -1
Solution().minimumTotal(input2)


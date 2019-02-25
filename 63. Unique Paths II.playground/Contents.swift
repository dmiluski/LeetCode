import Foundation

/*
 63. Unique Paths II
 Medium

 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

 The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

 Now consider if some obstacles are added to the grids. How many unique paths would there be?

 An obstacle and empty space is marked as 1 and 0 respectively in the grid.

 Note: m and n will be at most 100.

 Example 1:

 Input:
 [
 [0,0,0],
 [0,1,0],
 [0,0,0]
 ]
 Output: 2
 Explanation:
 There is one obstacle in the middle of the 3x3 grid above.
 There are two ways to reach the bottom-right corner:
 1. Right -> Right -> Down -> Down
 2. Down -> Down -> Right -> Right
 */

// Model for storing Known Counts
struct Point: Hashable {
    let m: Int
    let n: Int

    func incrementingM() -> Point {
        return Point(m: m+1, n: n)
    }

    func incrementingN() -> Point {
        return Point(m: m, n: n+1)
    }
}

class Solution {

    /*
     Approach - Recursion

     Thoughts:
     I've found copying an array is very expensive. Instead, pass in locations within the grid
     to calculate next step. Given this point, we can still memoize like in `62. Unique Paths`
     */


    /// Recursively Finds Unique Paths through a grid of paths/obastacles
    /// - parameters:
    ///       - obstacleGrid: Intput marking open spaces (0) / obastacles(1)
    ///       - point: Point where we are on the grid
    ///       - memoizedStorage: reference to storage for cached lookups
    /// - returns: Number of unique ways to step through grid
    private func recurseUniquePathsWithObstacles(_ obstacleGrid: [[Int]],
                                  point: Point,
                                  memoizedStorage: inout [Point: Int]) -> Int {


        // Inspect Grid Remaining
        let remainingM = obstacleGrid.count - point.m
        guard remainingM > 0 else { return 0 }

        let remainingN = obstacleGrid[point.m].count - point.n
        guard remainingN > 0 else { return 0 }

        // Sentinel Check for obstacles / Out of bounds
        //  - Path: 0
        //  - Obstacle: 1
        guard obstacleGrid[point.m][point.n] == 0 else { return 0 }

        switch (remainingM, remainingN) {
        case (1,1):
            // Sentinel End
            return 1
        case (2...,2...):
            // Can Go Both Ways
            let moveMPoint = point.incrementingM()
            let moveNPoint = point.incrementingN()

            // Check memoized value, the fallback to recurse
            let travelPathM = memoizedStorage[moveMPoint] ?? recurseUniquePathsWithObstacles(obstacleGrid,
                                                                                  point: moveMPoint,
                                                                                  memoizedStorage: &memoizedStorage)
            let travelPathN = memoizedStorage[moveNPoint] ?? recurseUniquePathsWithObstacles(obstacleGrid,
                                                                                  point: moveNPoint,
                                                                                  memoizedStorage: &memoizedStorage)

            // Update memoization
            memoizedStorage[moveMPoint] = travelPathM
            memoizedStorage[moveNPoint] = travelPathN

            return travelPathM + travelPathN

        case (1, 2...):
            let moveNPoint = point.incrementingN()
            let travelPathN = memoizedStorage[moveNPoint] ?? recurseUniquePathsWithObstacles(obstacleGrid,
                                                                                             point: moveNPoint,
                                                                                             memoizedStorage: &memoizedStorage)
            memoizedStorage[moveNPoint] = travelPathN

            return travelPathN
        case (2..., 1):
            let moveMPoint = point.incrementingM()
            let travelPathM = memoizedStorage[moveMPoint] ?? recurseUniquePathsWithObstacles(obstacleGrid,
                                                                                             point: moveMPoint,
                                                                                             memoizedStorage: &memoizedStorage)
            memoizedStorage[moveMPoint] = travelPathM

            return travelPathM
        default:
            fatalError("Negative Numbers should not exist here")
        }
    }

    /// Counts Unique Paths through a grid of potential paths/obstacles
    /// - parameters:
    ///       - obstacleGrid: Intput marking open spaces (0) / obastacles(1)
    ///       - point: Point where we are on the grid
    ///       - memoizedStorage: reference to storage for cached lookups
    /// - returns: Number of unique ways to step through grid
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        guard obstacleGrid.count > 0 else { return 0}

        var storage = [Point: Int]()
        return recurseUniquePathsWithObstacles(obstacleGrid,
                                               point: Point(m: 0, n: 0),
                                               memoizedStorage: &storage)
    }
}

//let input = [
//    [0,0,0],
//    [0,1,0],
//    [0,0,0]
//]
//Solution().uniquePathsWithObstacles(input)

let input2 = [[0,1]]
Solution().uniquePathsWithObstacles(input2)

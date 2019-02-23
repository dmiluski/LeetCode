import Foundation

/*
62. Unique Paths
 Medium

 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

 The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

 How many possible unique paths are there?
 */

// Model for storing Known Counts
struct Point: Hashable {
    let m: Int
    let n: Int
}

class Solution {

    /*
     Approach - Recursion

     Similar to (55/70) we can step through an array of items and try each variant

     Given it's recursive, we're likely to see duplicates. To save time recursing down paths multiple times
     we can memoize options.
     */

    /// Recursively Finds Unique Paths through a grid
    /// - parameters:
    ///       - m: number of columns (> 0)
    ///       - n: number of rows (> 0)
    ///       - memoizedStorage: reference to storage for cached lookups
    /// - returns: Number of unique ways to step through grid
    func recurseUniquePaths(_ m: Int,
                     _ n: Int,
                     memoizedReference: inout [Point: Int]) -> Int {

        switch (m, n) {
        case (1,1):
            // Sentinel End
            return 1
        case (2...,2...):
            // Can Go Both Ways
            let moveMPoint = Point(m: m-1, n: n)
            let moveNPoint = Point(m: m, n: n-1)

            // Check memoized value, the fallback to recurse
            let travelPathM = memoizedReference[moveMPoint] ?? recurseUniquePaths(moveMPoint.m, moveMPoint.n, memoizedReference: &memoizedReference)
            let travelPathN = memoizedReference[moveNPoint] ?? recurseUniquePaths(moveNPoint.m, moveNPoint.n, memoizedReference: &memoizedReference)

            // Update memoization
			memoizedReference[moveMPoint] = travelPathM
            memoizedReference[moveNPoint] = travelPathN

            return travelPathM + travelPathN

        case (1, 2...):
            // Can Travel down `n` (Unique)
            return 1
        case (2..., 1):
            // Can Travel down `m` (Unique)
            return 1
        default:
            fatalError("Negative Numbers should not exist here")
        }
    }

    /// Recursively Finds Unique Paths through a grid


    /// Finds Unique Paths through a grid
    /// - parameters:
    ///		- m: number of columns (> 0)
    ///		- n: number of rows (> 0)
    /// - returns: Number of unique ways to step through grid
    func uniquePaths(_ m: Int,
                     _ n: Int) -> Int {
        guard m > 0,
            n > 0 else { return 0}

        var storage = [Point: Int]()
        return recurseUniquePaths(m, n, memoizedReference: &storage)


    }
}

Solution().uniquePaths(3, 2) == 3
Solution().uniquePaths(7, 3)


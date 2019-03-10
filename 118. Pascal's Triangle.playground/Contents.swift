import Foundation

/*
 118. Pascal's Triangle
 Easy

 GGiven a non-negative integer numRows, generate the first numRows of Pascal's triangle.


 In Pascal's triangle, each number is the sum of the two numbers directly above it.

 Example:

 Input: 5
 Output:
 [
 [1],
 [1,1],
 [1,2,1],
 [1,3,3,1],
 [1,4,6,4,1]
 ]
 */

class Solution {
    /// Given existing Pascal Row, generate row after
    ///
    /// - Parameters:
    ///     - row: Prior row for calculating new values
    private func generatePascalRowAfter(row: [Int]) -> [Int] {

        // Required First Row
        guard row.count > 0 else {
            return [1]
        }

        // Required Second Row
        guard row.count > 1 else {
            return [1, 1]
        }

        guard let first = row.first,
            let last = row.last else { fatalError() }


        let middle = zip(row, row.dropFirst()).map { (lhs, rhs) -> Int in
            return lhs + rhs
        }

        return [first] + middle + [last]
    }

    func generate(_ numRows: Int) -> [[Int]] {

        guard numRows > 0 else { return [] }


        // Base Row
        var currentRow: [Int] = []
        var rows = [[Int]]()

        for _ in 1...numRows {
            let nextRow = generatePascalRowAfter(row: currentRow)
            rows.append(nextRow)
            currentRow = nextRow
        }

        return rows
    }
}

Solution().generate(5) == [
        [1],
       [1,1],
      [1,2,1],
     [1,3,3,1],
    [1,4,6,4,1]
]

Solution().generate(6) == [
        [1],
       [1,1],
      [1,2,1],
     [1,3,3,1],
    [1,4,6,4,1],
   [1,5,10,10,5,1]
]

Solution().generate(1)


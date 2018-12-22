import Foundation

/*
 36. Valid Sudoku

 Determine if a 9x9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

 Each row must contain the digits 1-9 without repetition.
 Each column must contain the digits 1-9 without repetition.
 Each of the 9 3x3 sub-boxes of the grid must contain the digits 1-9 without repetition.

 A partially filled sudoku which is valid.

 The Sudoku board could be partially filled, where empty cells are filled with the character '.'.

 Example 1:

 Input:
 [
 ["5","3",".",".","7",".",".",".","."],
 ["6",".",".","1","9","5",".",".","."],
 [".","9","8",".",".",".",".","6","."],
 ["8",".",".",".","6",".",".",".","3"],
 ["4",".",".","8",".","3",".",".","1"],
 ["7",".",".",".","2",".",".",".","6"],
 [".","6",".",".",".",".","2","8","."],
 [".",".",".","4","1","9",".",".","5"],
 [".",".",".",".","8",".",".","7","9"]
 ]
 Output: true
 Example 2:

 Input:
 [
 ["8","3",".",".","7",".",".",".","."],
 ["6",".",".","1","9","5",".",".","."],
 [".","9","8",".",".",".",".","6","."],
 ["8",".",".",".","6",".",".",".","3"],
 ["4",".",".","8",".","3",".",".","1"],
 ["7",".",".",".","2",".",".",".","6"],
 [".","6",".",".",".",".","2","8","."],
 [".",".",".","4","1","9",".",".","5"],
 [".",".",".",".","8",".",".","7","9"]
 ]
 Output: false
 Explanation: Same as Example 1, except with the 5 in the top left corner being
 modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
 Note:

 A Sudoku board (partially filled) could be valid but is not necessarily solvable.
 Only the filled cells need to be validated according to the mentioned rules.
 The given board contain only digits 1-9 and the character '.'.
 The given board size is always 9x9.

 */

class Solution {

    func isValidSudoku(_ board: [[Character]]) -> Bool {
        // Step through the validation
        // Extract All Rows as [Char]
        // Extract all Collums as [Char]
        // Extract all 9 x 9 Boxes [Char]
        // Validate contains no repeats on a per Array basis

        // Full Suite (takes unnecessary time to evaluate portion
        // So instead evaluate lazily and only build arrays if necessary (Below)
//        let suite = rows(for: board) + colums(for: board) + grids(for: board)
//        return suite.first(where: { !self.isValid(group: $0) } ) == nil

        return rows(for: board).first(where: { !self.isValid(group: $0) } ) == nil &&
            colums(for: board).first(where: { !self.isValid(group: $0) } ) == nil &&
            grids(for: board).first(where: { !self.isValid(group: $0) } ) == nil
    }

    // Per Group Validation (Require Unique elements in set)
    func isValid(group: [Character]) -> Bool {
        // Goal Identify Duplicates (Set)
        let digits = group.filter({ $0 != "." })
        let uniques = Set(digits)
        return digits.count == uniques.count
    }

    func rows(for board:  [[Character]]) -> [[Character]] {
        return board
    }

    func colums(for board: [[Character]]) -> [[Character]] {
        var colums: [[Character]] = []
        for index in 0..<9 {
            colums.append(board.map({ $0[index] }))
        }
        return colums
    }

    func grids(for board: [[Character]]) -> [[Character]] {
        var grids: [[Character]] = []
        grids.reserveCapacity(9)


        for columnMultiplier in 0..<3 {
            for rowMultiplier in 0..<3 {
                var grid: [Character] = []
                grid.reserveCapacity(9)

                let startingRow = rowMultiplier * 3
                let startingColumn = columnMultiplier * 3
                for columnOffset in 0..<3 {
                    for rowOffset in 0..<3 {
                        grid.append(board[startingColumn + columnOffset][startingRow + rowOffset])

                    }
                }
                grids.append(grid)
            }
        }

        return grids
    }
}


// Tests
let inputv1: [[Character]] = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]

let inputv2: [[Character]] = [
    ["8","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]

Solution().isValidSudoku(inputv1) == true
Solution().isValidSudoku(inputv2) == false





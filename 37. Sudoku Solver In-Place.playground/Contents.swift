import Foundation

/*
 37. Sudoku Solver

 Write a program to solve a Sudoku puzzle by filling the empty cells.

 A sudoku solution must satisfy all of the following rules:

 Each of the digits 1-9 must occur exactly once in each row.
 Each of the digits 1-9 must occur exactly once in each column.
 Each of the the digits 1-9 must occur exactly once in each of the 9 3x3 sub-boxes of the grid.
 Empty cells are indicated by the character '.'.


 A sudoku puzzle...


 ...and its solution numbers marked in red.

 Note:

 The given board contain only digits 1-9 and the character '.'.
 You may assume that the given Sudoku puzzle will have a single unique solution.
 The given board size is always 9x9.
 */

struct Position: Equatable {
    static let last = Position(row: 8, column: 8)

    let row: Int
    let column: Int
}


extension Character {
    var isEditable: Bool {
        return self == "."
    }
}
extension CharacterSet {
    static let arabicNumbers = CharacterSet(charactersIn: "0123456789")
    static let sudokuNumbers = CharacterSet(charactersIn: "123456789")
}
extension Array where Element == Character {
    var values: [Character] {
        return self
            .filter({ CharacterSet.arabicNumbers.contains($0.unicodeScalars.first!) })
    }

    // Checks validity of Array (unique values) nil items ignored
    var isValid: Bool {
        let nonNilValues = values
        let uniques = Set(nonNilValues)
        return uniques.count == nonNilValues.count
    }

    /// Check validity of Array (unique values) requiring all items have a value
    var isSolved: Bool {
        let uniques = Set(values)
        return uniques.count == count && uniques.count == 9
    }
}

extension Array where Element == [Character] {
    
    // O(n) Access
    var columns: [[Character]] {
        var columns = [[Character]]()
        columns.reserveCapacity(9)
        for columnIndex in 0..<9 {
            var column = [Character]()
            column.reserveCapacity(9)
            for row in self {
                column.append(row[columnIndex])
            }
            columns.append(column)
        }
        return columns
    }
    
    // O(n) access
    var grids: [[Character]] {
        var grids: [[Character]] = []
        
        for columnMultiplier in 0..<3 {
            for rowMultiplier in 0..<3 {
                var grid: [Character] = []
                grid.reserveCapacity(9)
                
                let startingRow = rowMultiplier * 3
                let startingColumn = columnMultiplier * 3
                for columnOffset in 0..<3 {
                    for rowOffset in 0..<3 {
                        grid.append(self[startingColumn + columnOffset][startingRow + rowOffset])
                        
                    }
                }
                grids.append(grid)
            }
        }
        
        return grids
    }
    
    /// Returns the grid containing this Position
    func grid(for position: Position) -> [Character] {
        switch (position.row, position.column) {
        case (0..<3, 0..<3): return grids[0]
        case (0..<3, 3..<6): return grids[1]
        case (0..<3, 6..<9): return grids[2]
        case (3..<6, 0..<3): return grids[3]
        case (3..<6, 3..<6): return grids[4]
        case (3..<6, 6..<9): return grids[5]
        case (6..<9, 0..<3): return grids[6]
        case (6..<9, 3..<6): return grids[7]
        case (6..<9, 6..<9): return grids[8]
        default:
            fatalError()
        }
    }
    
    func index(after position: Position) -> Position? {
        // First Attempt to visit Right?
        if let index = self[position.row].index(position.column, offsetBy: 1, limitedBy: self[position.row].count - 1) {
            return Position(row: position.row, column: index)
        }
        // Then Attempt next row
        else if let index = self.index(position.row, offsetBy: 1, limitedBy: count - 1) {
            return Position(row: index, column: 0)
        }
        return nil
    }
    
    func possibleValues(for position: Position) -> [Character] {
        let rowValues = self[position.row]
        let columnValues = columns[position.column]
        let gridValues = grid(for: position)

        
        let existingValues = Set<Character>()
            .union(Set(rowValues))
            .union(Set(columnValues))
            .union(Set(gridValues))
        
        let set = Set(["1","2","3","4","5","6","7","8","9"]).subtracting(existingValues)
        
       return set.reversed()
    }
    
    var isValid: Bool {
        return first(where: { !$0.isValid } ) == nil &&
            columns.first(where: { !$0.isValid } ) == nil &&
            grids.first(where: { !$0.isValid } ) == nil
    }
    
    /// Is the Board filled in with unique values satisfying column/row/grid rules
    var isSolved: Bool {
        return self.first(where: { !$0.isSolved } ) == nil &&
            columns.first(where: { !$0.isSolved } ) == nil &&
            grids.first(where: { !$0.isSolved } ) == nil
    }
}

class Solution {

    /// Returns the row containing this Position
    func row(board: inout [[Character]], for position: Position) -> [Character] {
        return board[position.row]
    }
    
    /// Returns the column containing this Position
    func column(board: inout [[Character]], for position: Position) -> [Character] {
        return board.columns[position.column]
    }
    
    /// Returns the grid containing this Position
    func grid(board: inout [[Character]], for position: Position) -> [Character] {
        switch (position.row, position.column) {
        case (0..<3, 0..<3): return board.grids[0]
        case (0..<3, 3..<6): return board.grids[1]
        case (0..<3, 6..<9): return board.grids[2]
        case (3..<6, 0..<3): return board.grids[3]
        case (3..<6, 3..<6): return board.grids[4]
        case (3..<6, 6..<9): return board.grids[5]
        case (6..<9, 0..<3): return board.grids[6]
        case (6..<9, 3..<6): return board.grids[7]
        case (6..<9, 6..<9): return board.grids[8]
        default:
            fatalError()
        }
    }
    
    private func recursiveSolveSudoku(_ board: inout [[Character]], position: Position?) -> Bool {
        // Sentinal Check (If reached the end, check if valid)
        guard let position = position,
            board.indices.contains(position.row),
            board[position.row].indices.contains(position.column) else {
            return board.isSolved
        }

        let cell = board[position.row][position.column]

        // Attempt Options
        if cell.isEditable {

            // Iterate each option
            for value in board.possibleValues(for: position) {
                board[position.row][position.column] = value

                if recursiveSolveSudoku(&board, position: board.index(after: position)) {
                    return true
                }
            }
            board[position.row][position.column] = "."
            return false
        } else {
            return recursiveSolveSudoku(&board, position: board.index(after: position))
        }
    }

    func solveSudoku(_ board: inout [[Character]]) {
        recursiveSolveSudoku(&board, position: Position(row: 0, column: 0))
    }
}

var inputv1: [[Character]] = [
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

print(inputv1)
Solution().solveSudoku(&inputv1)

print(inputv1)

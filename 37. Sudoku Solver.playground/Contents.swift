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

class SudokuCell {
    var value: Int?
    let isEditable: Bool

    init(value: Int?) {
        self.value = value
        self.isEditable = value == nil
    }
}


extension SudokuCell: CustomStringConvertible {
    // MARK: - CustomStringConvertible
    var description: String {
        guard let value = value else { return " "}
        return String(value)
    }
}

extension Array where Element == SudokuCell {
    var values: [Int] {
        return self.compactMap({ $0.value })
    }

    // Checks validity of Array (unique values) nil items ignored
    var isValid: Bool {
        let nonNilValues = self.compactMap({ $0.value })
        let uniques = Set(nonNilValues)
        return uniques.count == nonNilValues.count
    }

    /// Check validity of Array (unique values) requiring all items have a value
    var isSolved: Bool {
        let uniques = Set(values)
        return uniques.count == count && uniques.count == 9
    }
}

class SudokuBoard: CustomStringConvertible {

    // MARK: - Properties

    let cells: [[SudokuCell]]

    let rows: [[SudokuCell]]
    let columns: [[SudokuCell]]
    let grids: [[SudokuCell]]

    // MARK: - Initialization

    init?(input: [[Int?]]) {
        // Verify Input
        // Assuming 9 x 9 Board
        let expectedCount = 9
        guard input.count == expectedCount,
            input.filter({ return $0.count == expectedCount}).count == expectedCount else { return nil }



        self.cells = SudokuBoard.cells(for: input)
        self.rows = SudokuBoard.rows(for: cells)
        self.columns = SudokuBoard.columns(for: cells)
        self.grids = SudokuBoard.grids(for: cells)
    }

    // MARK: - CustomStringConvetible
    var description: String {

        // Customize for easy to view GRID Description
        return cells
            .map({ $0.description })
            .joined(separator: "\n")
    }

    var isValid: Bool {
        return rows.first(where: { !$0.isValid } ) == nil &&
            columns.first(where: { !$0.isValid } ) == nil &&
            grids.first(where: { !$0.isValid } ) == nil
    }

    /// Is the Board filled in with unique values satisfying column/row/grid rules
    var isSolved: Bool {
        return rows.first(where: { !$0.isSolved } ) == nil &&
            columns.first(where: { !$0.isSolved } ) == nil &&
            grids.first(where: { !$0.isSolved } ) == nil
    }

    // MARK: - Related Cells Helpers

    /// Given Row / Colum / Grid for this position, returns remaing values available for this position
    func possibleValues(for position: Position) -> [Int] {

        let rowValues = row(for: position).values
        let columnValues = column(for: position).values
        let gridValues = grid(for: position).values

        let existingValues = Set<Int>()
            .union(Set(rowValues))
            .union(Set(columnValues))
            .union(Set(gridValues))

        return Array (Set([1,2,3,4,5,6,7,8,9]).subtracting(existingValues))
    }

    /// Returns the row containing this Position
    func row(for position: Position) -> [SudokuCell] {
        return cells[position.row]
    }

    /// Returns the column containing this Position
    func column(for position: Position) -> [SudokuCell] {
        return columns[position.column]
    }

    /// Returns the grid containing this Position
    func grid(for position: Position) -> [SudokuCell] {
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
        if let index = cells[position.row]
            .index(position.column, offsetBy: 1, limitedBy: cells[position.row].count - 1) {
            return Position(row: position.row, column: index)
        }
        // Then Attempt next row
        else if let index = cells.index(position.row, offsetBy: 1, limitedBy: cells.count - 1) {
            return Position(row: index, column: 0)
        }
        return nil
    }
}

// MARK: - Initialization Helpers

extension SudokuBoard {
    private static func cells(for input: [[Int?]]) -> [[SudokuCell]] {
        var cells =  [[SudokuCell]]()
        cells.reserveCapacity(9)

        for row in input {
            var rowOfCells = [SudokuCell]()
            rowOfCells.reserveCapacity(9)

            for value in row {
                rowOfCells.append(SudokuCell(value: value))
            }
            cells.append(rowOfCells)
        }

        return cells
    }
    private static func rows(for cells: [[SudokuCell]]) -> [[SudokuCell]] {
        return cells
    }

    private static func columns(for cells: [[SudokuCell]]) -> [[SudokuCell]] {
        var columns = [[SudokuCell]]()
        columns.reserveCapacity(9)
        for columnIndex in 0..<9 {
            var column = [SudokuCell]()
            column.reserveCapacity(9)
            for row in cells {
                column.append(row[columnIndex])
            }
            columns.append(column)
        }
        return columns
    }

    private static func grids(for cells: [[SudokuCell]]) -> [[SudokuCell]] {
        var grids: [[SudokuCell]] = []

        for columnMultiplier in 0..<3 {
            for rowMultiplier in 0..<3 {
                var grid: [SudokuCell] = []
                grid.reserveCapacity(9)

                let startingRow = rowMultiplier * 3
                let startingColumn = columnMultiplier * 3
                for columnOffset in 0..<3 {
                    for rowOffset in 0..<3 {
                        grid.append(cells[startingColumn + columnOffset][startingRow + rowOffset])

                    }
                }
                grids.append(grid)
            }
        }

        return grids
    }
}



class Solution {
    // Log Every 50 attempts
    var isLogging: Bool = true
    private var recurseCount = 0

    private func recursiveSolveSudoku(_ board: SudokuBoard, position: Position?) -> Bool {

        // Sentinal Check (If reached the end, check if valid)
        guard let position = position,
            board.cells.indices.contains(position.row),
            board.cells[position.row].indices.contains(position.column) else {
            return board.isSolved
        }

        let cell = board.cells[position.row][position.column]


        if recurseCount % 50 == 0 && isLogging {
            print("\n")
            print(board)
        }
        recurseCount+=1

        // Attempt Options
        if cell.isEditable {

            // Iterate each option
            for value in board.possibleValues(for: position) {
                cell.value = value

                if recursiveSolveSudoku(board, position: board.index(after: position)) {
                    return true
                }
            }
            cell.value = nil
            return false
        } else {
            return recursiveSolveSudoku(board, position: board.index(after: position))
        }
    }

    func solveSudoku(_ board: [[Int?]]) {

        guard let board = SudokuBoard(input: board) else {
            print("Invalid board, not 9x9")
            return
        }

        print("Original Board")
        print(board)

        guard board.isValid else {
            print("Board is not valid (Input has character collisions)")
            return
        }

        recursiveSolveSudoku(board, position: Position(row: 0, column: 0))
        print("\nFinal Board")
        print(board)
    }
}

// Tests
// Possible Puzzle (Expect output)

let inputv1: [[Int?]] = [
    [5,3,nil,nil,7,nil,nil,nil,nil],
    [6,nil,nil,1,9,5,nil,nil,nil],
    [nil,9,8,nil,nil,nil,nil,6,nil],
    [8,nil,nil,nil,6,nil,nil,nil,3],
    [4,nil,nil,8,nil,3,nil,nil,1],
    [7,nil,nil,nil,2,nil,nil,nil,6],
    [nil,6,nil,nil,nil,nil,2,8,nil],
    [nil,nil,nil,4,1,9,nil,nil,5],
    [nil,nil,nil,nil,8,nil,nil,7,9]
]

let outputv1: [[Int]] = [
    [5, 3, 4, 6, 7, 8, 9, 1, 2],
    [6, 7, 2, 1, 9, 5, 3, 4, 8],
    [1, 9, 8, 3, 4, 2, 5, 6, 7],
    [8, 5, 9, 7, 6, 1, 4, 2, 3],
    [4, 2, 6, 8, 5, 3, 7, 9, 1],
    [7, 1, 3, 9, 2, 4, 8, 5, 6],
    [9, 6, 1, 5, 3, 7, 2, 8, 4],
    [2, 8, 7, 4, 1, 9, 6, 3, 5],
    [3, 4, 5, 2, 8, 6, 1, 7, 9]]

// Unsolvable Puzzle -> Expect (Identity) output
let inputv2: [[Int?]] = [
    [8,3,nil,nil,7,nil,nil,nil,nil],
    [6,nil,nil,1,9,5,nil,nil,nil],
    [nil,9,8,nil,nil,nil,nil,6,nil],
    [8,nil,nil,nil,6,nil,nil,nil,3],
    [4,nil,nil,8,nil,3,nil,nil,1],
    [7,nil,nil,nil,2,nil,nil,nil,6],
    [nil,6,nil,nil,nil,nil,2,8,nil],
    [nil,nil,nil,4,1,9,nil,nil,5],
    [nil,nil,nil,nil,8,nil,nil,7,9]
]

//Solution().solveSudoku(inputv1)
Solution().solveSudoku(inputv2)




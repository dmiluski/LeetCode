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

struct Position {
    let row: Int
    let column: Int
}

class SudokuCell: CustomStringConvertible {
    var value: Int?
    let position: Position
    let isEditable: Bool

    init(value: Int?, position: Position) {
        self.value = value
        self.position = position
        self.isEditable = value != nil
    }

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

    var isValid: Bool {
        let uniques = Set(values)
        return uniques.count == count &&
            uniques.count == 9
    }
}

struct SudokuBoard: CustomStringConvertible {
    let cells: [[SudokuCell]]

    private let rows: [[SudokuCell]]
    private let columns: [[SudokuCell]]
    private let grids: [[SudokuCell]]

    init(input: [[Int?]]) {
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

    var isSolved: Bool {
        return rows.first(where: { !$0.isValid } ) == nil &&
            columns.first(where: { !$0.isValid } ) == nil &&
            grids.first(where: { !$0.isValid } ) == nil
    }

    // MARK: - Related Cells Helpers

    func row(for position: Position) -> [SudokuCell] {
        return cells[position.row]
    }

    func column(for position: Position) -> [SudokuCell] {
        return columns[position.column]
    }

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
}

// MARK: - Initialization Helpers

extension SudokuBoard {
    private static func cells(for input: [[Int?]]) -> [[SudokuCell]] {
        var cells =  [[SudokuCell]]()
        cells.reserveCapacity(9)

        for (rowIndex, row) in input.enumerated() {
            var rowOfCells = [SudokuCell]()
            rowOfCells.reserveCapacity(9)

            for (columnIndex, value) in row.enumerated() {
                rowOfCells.append(SudokuCell(value: value, position: Position(row: rowIndex, column: columnIndex)))
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

        for yMultiplier in 1..<4 {
            for xMultiplier in 1..<4 {
                var grid: [SudokuCell] = []
                grid.reserveCapacity(9)

                for y in 0..<3 {
                    for x in 0..<3 {
                        grid.append(cells[yMultiplier*y][xMultiplier*x])
                    }
                }

                grids.append(grid)
            }
        }
        return grids
    }
}

class Solution {
    func solveSudoku(_ board: [[Int?]]) {
        print("Dane - 0")
        let sudokuBoard = SudokuBoard(input: board)
        print(sudokuBoard)

        // Brute force:
        // Try Each value 1 -> 9 For each cell and compare to row/column/grid
        // to see if it's satisfied

        var isSolved: Bool = false
        print("Dane")
        for attempt in 1..<9 where isSolved == false {
            for (rowIndex, row) in sudokuBoard.cells.enumerated() where isSolved == false {
                for (columnIndex, value) in row.enumerated() where isSolved == false {
                    print("\(rowIndex) - \(columnIndex)")
                    let rowValues = sudokuBoard.row(for: Position(row: rowIndex, column: columnIndex)).values
                    let columnValues = sudokuBoard.column(for: Position(row: rowIndex, column: columnIndex)).values
                    let gridValues = sudokuBoard.grid(for: Position(row: rowIndex, column: columnIndex)).values

                    // Is this valid? (Value Colisions)
                    let rowSet = Set(rowValues)
                    let columnSet = Set(columnValues)
                    let gridSet = Set(gridValues)

                    let existingValues = Set<Int>()
                        .union(rowSet)
                        .union(columnSet)
                        .union(gridSet)

                    let possibleValues = Set([1,2,3,4,5,6,7,8,9])
                        .subtracting(existingValues)

//                    print("PossibleValues at indesx: \(rowIndex), \(columnIndex) \(possibleValues)")
                    if !possibleValues.contains(attempt) && value.isEditable {
                        print("UpdatingValue: \(value) at \(rowIndex), \(columnIndex)")
                        value.value = attempt
                    }

                    if columnIndex == 8 {
                        print(sudokuBoard)
                    }

                    // Sentinel Check
                    if rowIndex == 8 &&
                        columnIndex == 8 &&
                        sudokuBoard.isSolved {
                        isSolved = true
                    }
                }

            }
        }

        print(sudokuBoard)
    }
}

// Tests
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

Solution().solveSudoku(inputv1)





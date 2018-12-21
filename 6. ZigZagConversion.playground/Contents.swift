//: Playground - noun: a place where people can play

import UIKit

/*
 Problem 6: ZigZig Conversion

 The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

 P   A   H   N
 A P L S I I G
 Y   I   R
 And then read line by line: "PAHNAPLSIIGYIR"

 Write the code that will take a string and make this conversion given a number of rows:

 string convert(string s, int numRows);
 Example 1:

 Input: s = "PAYPALISHIRING", numRows = 3
 Output: "PAHNAPLSIIGYIR"
 Example 2:

 Input: s = "PAYPALISHIRING", numRows = 4
 Output: "PINALSIGYAHRPI"
 Explanation:

 P     I    N
 A   L S  I G
 Y A   H R
 P     I
 */

// Approach:
//  Create a Grid of Optionals
//  Follow the path of the zig zag and fill in
//  Read out characters by row
class Solution {
    struct ZigZagGridIndex {
        let x: Int
        let y: Int
    }

    enum Direction {
        case down, diagonal
    }

    private func numberOfCollums(_ s: String, rows: Int) -> Int {
        var collums = 0
        var count = s.count
        print(count)
        while count > 0 {
            // Consider Verticals
            count -= rows
            print(count)
            collums += 1

            // Consider Diagonals
            for _ in 0 ..< (rows / 2) {

                if count > 0 {
                    count -= 1
                    collums += 1
                    print(count)
                }
            }

        }

        print("Collums: \(collums)")
        return collums
    }

    func convert(_ s: String, _ numRows: Int) -> String {
        // Mutable String for extracting characters
        var string = s

        // Construct Collums
        var numCollums = numberOfCollums(s, rows: numRows)

        // Construct Grid O(n)
        var grid: [[Character?]] = {
            var grid: [[Character?]] = []
            for _ in 0 ..< numCollums {
                let collum = [Character?](repeating: nil, count: numRows)
                grid.append(collum)
            }
            return grid
        }()

        var gridIndex = ZigZagGridIndex(x: 0, y: 0)
        var direction: Direction = .down

        // Place Values O(n)
        for (_, char) in string.enumerated() {
            grid[gridIndex.x][gridIndex.y] = char
            print(grid)

            switch direction {
            case .down:
                if gridIndex.y + 1 >= numRows {
                    // Determine if we can still go down?
                    gridIndex = ZigZagGridIndex(x: gridIndex.x + 1, y: gridIndex.y - 1)
                    direction = .diagonal
                } else {
                    // Continue
                    gridIndex = ZigZagGridIndex(x: gridIndex.x, y: gridIndex.y + 1)
                    direction = .down
                }

            case .diagonal:
                if gridIndex.y == 0 {
                    // Determine if we can still go up?
                    gridIndex = ZigZagGridIndex(x: gridIndex.x, y: gridIndex.y + 1)
                    direction = .down

                } else {
                    gridIndex = ZigZagGridIndex(x: gridIndex.x + 1, y: gridIndex.y - 1)
                    direction = .diagonal

                }
            }
        }

        // Extract Values by row to build Output String O(n)
        var output: String = ""
        for y in 0 ..< numRows {
            for x in 0 ..< numCollums {
                if let char = grid[x][y] {
                    output.append(char)
                }
            }
        }

        return output
    }
}

// Approach 2:
//  How to split up?
//  Given numRows:
//      Try to identify the pattern from first 3 letters
//      First Letter                    // index[0]     P
//      1 * charAt(2 * (numRows - 1))   // index[6]     I
//      2 * charAt(2 * (numRows - 1))   // index[12]    N
//
//  Find The Pattern
//
//
// Determine how many rows vs colums
// Given Length
//  Pattern:
//      NumRows, Then Single for each row between edges

// Tests
Solution().convert("PAYPALISHIRING", 3) == "PAHNAPLSIIGYIR"
Solution().convert("PAYPALISHIRING", 3)
Solution().convert("PAYPALISHIRING", 4) == "PINALSIGYAHRPI"
Solution().convert("PAYPALISHIRING", 4)




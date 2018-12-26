import Foundation

/*
 48. Rotate Image

 You are given an n x n 2D matrix representing an image.

 Rotate the image by 90 degrees (clockwise).

 Note:

 You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

 Example 1:

    Given input matrix =
    [
    [1,2,3],
    [4,5,6],
    [7,8,9]
    ],

    Rotate the input matrix in-place such that it becomes:
    [
    [7,4,1],
    [8,5,2],
    [9,6,3]
    ]
 Example 2:

    Given input matrix =
    [
    [ 5, 1, 9,11],
    [ 2, 4, 8,10],
    [13, 3, 6, 7],
    [15,14,12,16]
    ],

    Rotate the input matrix in-place such that it becomes:
    [
    [15,13, 2, 5],
    [14, 3, 4, 1],
    [12, 6, 8, 9],
    [16, 7,10,11]
    ]
 */


/*
 Approach: (Step through first line to find a pattern)
 Given input matrix =
 x, y
 0,0 -> 3,0
 1,0 -> 3,1
 2,0 -> 3,2
 3,0 -> 3,3

 0,1 -> 2,0
 1,1 -> 2,1
 2,1 -> 2,2
 3,0 -> 2,3

 Given this quick walkthrough I can see that although I can map the array coordinates
 to new coordinats, the pain point involves what to do with the value currently housed
 in that location?

 Considerations:
 - Potential for recursive solution returning value? Does this count as a separate array storage though?
 - Given the recurse, I'm assuming that it doesn't count as a second array? (Mapping from x -> y)

 */

class Solution {

    /**
     Rotates Matrix in Place

     - Parameters:
        - matrix: N x N 2D Matrix

     - Notes:
        - Time Complexity: O(n)
        - Space Complexity: Constant sized temp variable
    */
    func rotate(_ matrix: inout [[Int]]) {
        let rowCount = matrix.count

        // Given a Square
        //  - Use a temp var for top left item
        //  - Rotate Outermost Square Corners
        //  - Loop Through to rotate inner square corners
        for rowIndex in 0..<matrix.count / 2 {
            for columnIndex in rowIndex..<(rowCount - 1 - rowIndex) {
                let temp = matrix[rowIndex][columnIndex]

                // Top Left
                matrix[rowIndex][columnIndex] = matrix[rowCount-1-columnIndex][rowIndex]

                // Bottom Left
                matrix[rowCount-1-columnIndex][rowIndex] = matrix[rowCount-1-rowIndex][rowCount-1-columnIndex]

                // Bottom Right
                matrix[rowCount-1-rowIndex][rowCount-1-columnIndex] = matrix[columnIndex][rowCount-1-rowIndex]

                // Top Right
                matrix[columnIndex][rowCount-1-rowIndex] = temp
            }
        }
    }
}

// Tests Data
var inputv0 = [
    [0,1],
    [2,3]
]

let outputv0 = [
    [2,0],
    [3,1]
]

var inputv1 = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
]

let outputv1 = [
    [7,4,1],
    [8,5,2],
    [9,6,3]
]

var inputv2 = [
    [ 5, 1, 9,11],
    [ 2, 4, 8,10],
    [13, 3, 6, 7],
    [15,14,12,16]
]

let outputv2 = [
    [15,13, 2, 5],
    [14, 3, 4, 1],
    [12, 6, 8, 9],
    [16, 7,10,11]
]

var inputv3 = [
    [1,2,3,4,5],
    [6,7,8,9,10],
    [11,12,13,14,15],
    [16,17,18,19,20],
    [21,22,23,24,25]
]

let outputv3 = [
    [21,16,11,6,1],
    [22,17,12,7,2],
    [23,18,13,9,4],
    [24,19,14,10,5],
    [25,20]
]

// Tests
Solution().rotate(&inputv0)
inputv0 == outputv0

print(inputv1)
Solution().rotate(&inputv1)
print(inputv1)

inputv1 == outputv1

Solution().rotate(&inputv2)
inputv2 == outputv2

var foo = [
    [1,2,3,4,5],
    [6,7,8,9,10],
    [11,12,13,14,15],
    [16,17,18,19,20],
    [21,22,23,24,25]
]

Solution().rotate(&foo)
print(foo)

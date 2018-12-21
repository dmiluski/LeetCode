import Foundation

/*
 22. Generate Parentheses

 Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

 For example, given n = 3, a solution set is:

 [
 "((()))",
 "(()())",
 "(())()",
 "()(())",
 "()()()"
 ]
 */


class Solution {
    private func generateParenthesis(openCount: Int, closedCount: Int, buffer: String, output: inout [String]) {

        if openCount == 0 && closedCount == 0 {
            output.append(buffer)
            return
        } else {
            // Pair must be initiated by  Open
            if openCount > 0 {
                generateParenthesis(openCount: openCount - 1, closedCount: closedCount, buffer: buffer + "(", output: &output)
            }

            // Only add Closing if included opening is already added
            if closedCount > openCount {
                generateParenthesis(openCount: openCount, closedCount: closedCount - 1, buffer: buffer + ")", output: &output)
            }
        }
    }

    func generateParenthesis(_ count: Int) -> [String] {
        var generatedOutput: [String] = []
        generateParenthesis(openCount: count, closedCount: count, buffer: "", output: &generatedOutput)
        return generatedOutput
    }
}

// Tests:
Solution().generateParenthesis(3)

let expectedOutput =  [
    "((()))",
    "(()())",
    "(())()",
    "()(())",
    "()()()"
]

Solution().generateParenthesis(3).description == expectedOutput.description

import Foundation

/*
 20. Valid Parentheses

 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:

 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Note that an empty string is also considered valid.

 Example 1:

 Input: "()"
 Output: true
 Example 2:

 Input: "()[]{}"
 Output: true
 Example 3:

 Input: "(]"
 Output: false
 Example 4:

 Input: "([)]"
 Output: false
 Example 5:

 Input: "{[]}"
 Output: true
 */

// MARK: - Generic Bracket Interface

protocol BracketFormatProviding {
    var open: Character { get }
    var close: Character { get }
}

// MARK: - Bracket Types

struct CurlyBrace: BracketFormatProviding, Equatable {
    let open: Character = "{"
    let close: Character = "}"
}

struct Parentheses: BracketFormatProviding, Equatable {
    let open: Character = "("
    let close: Character = ")"
}

struct SquareBracket: BracketFormatProviding, Equatable {
    let open: Character = "["
    let close: Character = "]"
}

/// Model for identifying/mapping Open/Close Characters
enum Brackets: Equatable {
    case curly(CurlyBrace)
    case parenthesis(Parentheses)
    case square(SquareBracket)

    init?(open: Character) {
        switch open {
        case CurlyBrace().open: self = .curly(CurlyBrace())
        case Parentheses().open: self = .parenthesis(Parentheses())
        case SquareBracket().open: self = .square(SquareBracket())
        default: return nil
        }
    }

    init?(close: Character) {
        switch close {
        case CurlyBrace().close: self = .curly(CurlyBrace())
        case Parentheses().close: self = .parenthesis(Parentheses())
        case SquareBracket().close: self = .square(SquareBracket())
        default: return nil
        }
    }
}

// MARK: - Bracket Conformance
extension Brackets {

    private var bracket: BracketFormatProviding {
        switch self {
        case let .curly(bracket): return bracket
        case let .parenthesis(bracket): return bracket
        case let .square(bracket): return bracket
        }
    }
    var open: Character {
        return bracket.open
    }

    var close: Character {
        return bracket.close
    }
}


class Solution {
    // Given any open bracket, find matching character
    // If a new open bracket is found, stash current, find character within substring
    // If a close bracket appears before an open, it's invalid
    func recurseIsValid(_ string: String, mostRecentOpenBracket: Brackets?) -> (isValid: Bool, remaining: String) {
        switch (string.first, mostRecentOpenBracket) {
        case (nil, nil):
            // Sentinal (End Comparison)
            return (isValid: true, remaining: string)
        case (nil, _):
            // Mismatch (No remaining characters to mtach open char)
            return (isValid: false, remaining: string)
        case let (first?, nil):
            // Check if open Bracket, otherwise, invalid
            guard let bracket = Brackets(open: first) else {
                return (isValid: false, remaining: string)
            }

            // Once we've found an open bracket, Search reamining string
            let suffix = String(string.suffix(from: string.index(after: string.startIndex)))
            let tuple = recurseIsValid(suffix, mostRecentOpenBracket: bracket)

            guard tuple.isValid else {
                return (isValid: false, remaining: tuple.remaining)
            }
            return recurseIsValid(tuple.remaining, mostRecentOpenBracket: nil)

        case let (first?, bracket?):
            switch (Brackets(close: first), Brackets(open: first)) {

            case let (closeBracket?, _) where closeBracket == bracket:
                // Matching Close Bracket (Partial Success in SubString)
                // Continue with remaining portion and original bracket

                let suffix = String(string.suffix(from: string.index(after: string.startIndex)))
                return (isValid: true, remaining: suffix)
            case let (_, openBracket?):
                // New Open Bracket (Recurse with substring)
                let suffix = String(string.suffix(from: string.index(after: string.startIndex)))
                let tuple = recurseIsValid(suffix, mostRecentOpenBracket: openBracket)
                return recurseIsValid(tuple.remaining, mostRecentOpenBracket: bracket)

            default:
                // Mismatched Brackets
                return (isValid: false, remaining: string)
            }
        }
    }

    func isValid(_ string: String) -> Bool {
        return recurseIsValid(string, mostRecentOpenBracket: nil).isValid
    }
}

// Tests:
Solution().isValid("") == true
Solution().isValid("()") == true
Solution().isValid("()[]{}") == true
Solution().isValid("(]") == false
Solution().isValid("([)]") == false
Solution().isValid("{[]}") == true
Solution().isValid("[]{[(){}]{}}") == true




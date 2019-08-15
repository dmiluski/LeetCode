import Foundation
/*
 131. Palindrome Partitioning
 Medium

 Given a string s, partition s such that every substring of the partition is a palindrome.

 Return all possible palindrome partitioning of s.

 Example:

 Input: "aab"
 Output:
 [
 ["aa","b"],
 ["a","a","b"]
 ]
 */

/// Approach:
/// Leverage Permutation to identify all permutations, the filter down to only items that are palindromes

extension Array {
    /**
     Decompose the first element of an array from its suffix subcollection
     */
    var decompose: (head: Element, remaining: [Element])? {
        guard let first = self.first else { return nil }
        return (first, Array(self[1..<count]))
    }

    /**
     Decompose and Construct PermutationTree (walk each option and map to an array output)
     */
    ///
    var permutations: [[Element]] {
        if let (head, suffix) = decompose {
            return suffix.permutations.flatMap({ return between(x: head, ys: $0)})
        } else {
            return [[]]
        }
    }
}

/**
 Creates all possibilities of x placements in array

 - Parameters:
 - x: The element to place in each possible position
 - ys: Array of which we want to place x in each possible position

 - Returns: Array of Arrays where (x) is placed in each possible position of array (ys)
 */
func between<T>(x: T, ys: [T]) -> [[T]] {
    guard let (head, suffix) = ys.decompose else { return [[x]] }

    // Construct Response using current ordered item, followed by collection item(x) in each position
    return [[x] + ys] + between(x: x, ys: suffix).map({ [head] + $0 })
}

extension String {
    var isPalindrome: Bool {
        return self == String(self.reversed())
    }
}

class Solution {
    func partition(_ s: String) -> [[String]] {

        // Construct all Permutations
        let permutations = Array(s)
            .permutations
            .map { (characters) -> String in
                return String(characters)
        }

        print(permutations)
        return []
        //            return permutations
    }
}


Solution().partition("aab")

import Foundation

/*
 46. Permutations

 Given a collection of distinct integers, return all possible permutations.

 Example:

 Input: [1,2,3]
 Output:
 [
 [1,2,3],
 [1,3,2],
 [2,1,3],
 [2,3,1],
 [3,1,2],
 [3,2,1]
 ]
 */

/*
 Reference Blog: https://www.objc.io/blog/2014/12/08/functional-snippet-10-permutations/

 Approach:
 1. Decompose: Separate first element from the rest of the array
    This allows us to setup
 2. Recurse to custruct Permutation Tree of Options
 3.

 */

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


// Tests
print([1,2,3].permutations)
print(Array("abc").permutations)

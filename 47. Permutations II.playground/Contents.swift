import Foundation

/*
 47. Permutations II

 Given a collection of numbers that might contain duplicates, return all possible unique permutations.

 Example:

 Input: [1,1,2]
 Output:
 [
 [1,1,2],
 [1,2,1],
 [2,1,1]
 ]
 */

/*
 Approach: Given prior permutation implementation, leverage Set to provide uniqing filter
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

extension Array where Element:Hashable {
    var uniquePermutations: [[Element]] {
        let set = Set(permutations)

        return Array<[Element]>(set)
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
[1,2,1].permutations
[1,2,1].uniquePermutations
[1,1,1].uniquePermutations

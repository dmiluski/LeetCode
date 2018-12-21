//: Playground - noun: a place where people can play

import Foundation


/*
 16. 3Sum Closest

Given an array nums of n integers and an integer target, find three integers in nums such that the sum is closest to target. Return the sum of the three integers. You may assume that each input would have exactly one solution.

Example:

Given array nums = [-1, 2, 1, -4], and target = 1.

The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
 */

extension Collection where Element: Numeric {
    /// Returns the sum of all elements in the collection
    var sum: Element {
        return reduce(0, +)
    }
}

struct Model {
    let values: [Int]
    let sum: Int

    var displayableValue: String {
        let displayableSum = values
            .map(String.init)
            .joined(separator: " + ")

        return "(\(displayableSum)) = \(sum)"
    }
}


extension Array where Element == Model {
    // Assumes Sorted Array (Increasing)
    func nearestValuesToTarget(_ target: Int) -> Model? {
        guard let first = first else { return nil }

        var model = first

        for (_, value) in enumerated() {
            if  abs(value.sum.distance(to: target)) < abs(model.sum.distance(to: target)) {
                model = value
            } else {
                break
            }
        }
        return model
    }
}
// Permutation Support
extension Array {

    // Extract First Value vs everything else
    private func decompose() -> (Iterator.Element, [Iterator.Element])? {
        guard let first = first else { return nil }
        return (first, Array(suffix(from: 1)))
    }

    // Determine all permutations of a single element with each possibility of current array
    private func between(item: Element) -> [[Element]] {
        guard let (head, tail) = decompose() else { return [[item]] }
        print("Between")
        print(item)
        print(self)
        print(tail.between(item: item).map({ [head] + $0}))
        print("\n")
        return [[item] + self] + tail.between(item: item).map({ [head] + $0})
    }

    // Returns all permutations of array values
    func permutations() -> [[Iterator.Element]] {
        guard let (head, tail) = decompose() else { return [[]] }
        print("permutations")
        print(self)
        print("\n")
        return tail.permutations().flatMap({ $0.between(item: head) })
    }
}

// Set Size Permutation Support
//extension Array {
//    private func between(item: Element, size: Int) -> [[Element]] {
//        guard let (head, tail) = decompose() else { return [[item]] }
//        print(item)
//        print(self)
//        print("\n")
//        return [[item] + self] + tail.between(item: item).map({ [head] + $0})
//    }
//
//    // The problem with the permutation approach is that we need to
//    // Provide a limit for each permutatin and ensure each possibility is still covered.
//    func permutations(with size: Int) -> [[Iterator.Element]] {
//        guard let (head, tail) = decompose() else { return [[]] }
//        return tail.permutations(with: size).flatMap({ $0.between(item: head) })
//    }
//}

//["a", "b", "c", "d", "e"].permutations().count
class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {

        guard let nearestModel = nums.permutations()
            .map({ (values) -> Model in
                return Model(values: values, sum: values.sum)
            })
            .sorted(by: { $0.sum < $1.sum })
            .nearestValuesToTarget(target) else { fatalError() }

        // Just logging all permutations
        print(nums.permutations()
            .map({ (values) -> Model in
                return Model(values: values, sum: values.sum)
            })
            .sorted(by: { $0.sum < $1.sum })
            .map({$0.displayableValue}))

        print(nearestModel)
        return nearestModel.sum
    }
}

// Test
Solution().threeSumClosest([-1, 2, 1, -4], 1)

/*
 Requirements

 - Come up with all sums                                                        (Permutate)
 - retain items (for printing) along with sum                                   (Keep Model of permuations an printable values)
 - Given output of sum -> displayable value, compare which sum is closest       (Search for nearest Sum)

 Potential for optimization:
 - Given sorted, we can leverage search?
 - Limit values considered to only those that would be close?
 */
// Requirements





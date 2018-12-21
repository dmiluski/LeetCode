import Foundation

/*
 15. 3Sum

 Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

 Note:

 The solution set must not contain duplicate triplets.

 Example:

 Given array nums = [-1, 0, 1, 2, -1, -4],

 A solution set is:
 [
 [-1, 0, 1],
 [-1, -1, 2]
 ]
 */


/*
 First Approach:

 Problems:
 Don't include duplicates
    Options: Given arrays of Ints aren't hashable, this removes the possibility of easy dupe detection

 When to stop considering a given element
    Unable to just stop considering one element b/c it's farther from  0

    My approach, though not efficient in time/space
    - Start outside in
    - Recurse by removing lower or top
    - Exit early if top/bottom offer no possibility of summing to 0

    Given recursion will lead to duplicates remove duplcates at end by checking if the item already exists


 Thoughts while reviewing Solution Posts
 Looks like recursion was not the way to go here. We can likely tackle this in limited space and time better iteratively
*/

extension Collection where Element: Numeric {
    /// Returns the sum of all elements in the collection
    var sum: Element {
        return reduce(0, +)
    }
}



// Sorted Array Helpers
extension Array where Element: Comparable {

    /// Requires Increasing Sorted Array
    /// - Complexity: O(log(n)), where *n* is equal to `maxLength`.
    /// - Space Complexity O(n)
    func binarySearchContains(_ item: Element) -> Bool {
        var lowerIndex = 0
        var upperIndex = count - 1

        while lowerIndex <= upperIndex {
            let midIndex = (lowerIndex + upperIndex) / 2

            let upperValue = self[upperIndex]
            let lowerValue = self[lowerIndex]
            let middleValue = self[midIndex]

            if item == upperValue || item == lowerValue || item == middleValue {
                return true
            } else if item > upperValue {
                return false
            } else if item < lowerValue {
                return false
            }  else if item < middleValue {
                upperIndex = midIndex - 1
            } else {
                lowerIndex = midIndex + 1
            }
        }
        return false
    }

    func dropLastRepeating() -> ArraySlice<Element> {
        guard let last = last else { return [] }

        var repetitions = 0
        for (index, value) in self.reversed().enumerated() {
            if value == last {
                repetitions += 1
            } else {
                break
            }
        }
        return self.dropLast(repetitions)
    }

    func dropFirstRepeating() -> ArraySlice<Element> {
        guard let first = first else { return [] }

        var repetitions = 0
        for (index, value) in self.enumerated() {
            if value == first {
                repetitions += 1
            } else {
                break
            }
        }
        return self.dropFirst(repetitions)
    }


}

class Solution {
    // Private implementation assumed already sorted
    // Retain input as array to maintain order
    // Returns a Set of Strings (Comma separated Integer Values)
    private func recursiveThreeSum(_ nums: [Int]) -> Set<String> {
        guard nums.count >= 3,
            let lower = nums.first,
            let upper = nums.last,
            !((lower > 0 && upper > 0) || (lower < 0 && upper < 0)) else { return [] }

        var output: Set<String> = []

        // Search via Set contains Lookup
        let requiredValue = -(lower + upper)
        var quickSearchSet: Set<Int> = []
        let subset = Array(nums.dropLast().dropFirst())
        quickSearchSet.formUnion(subset)
        if quickSearchSet.contains(requiredValue) {
            let stringStorage = [lower, requiredValue, upper].map(String.init).joined(separator: ",")
            output.insert(stringStorage)
        }

        // Given we are checking edge sums with quick search via Set, no need to retain edges if
        // they repeat elsewhere
        //
        // Skip repeating edge values as union check above should cover the equality check
        let droppedLastSums = recursiveThreeSum(Array(nums.dropLastRepeating()))
        if !droppedLastSums.isEmpty {
            output.formUnion(droppedLastSums)
        }

        let droppedFirstSums = recursiveThreeSum(Array(nums.dropFirstRepeating()))
        if !droppedFirstSums.isEmpty {
            output.formUnion(droppedFirstSums)
        }

        return output
    }

    func threeSum(_ nums: [Int]) -> [[Int]] {
        return recursiveThreeSum(nums.sorted())
            .map { (set) -> [Int] in
                return set
                    .split(separator: ",")
                    .map(String.init)
                    .compactMap(Int.init)
        }
    }
}

// Test
Solution()
    .threeSum([-1, 0, 1, 2, -1, -4]) == [
        [-1, 0, 1],
        [-1, -1, 2]
]

Solution()
    .threeSum([-1, 0, 1, 2, -1, -4])

Solution()
    .threeSum([-3,-2,-1,0,1,2,3])

Solution()
    .threeSum([0,0,0,0,0,0,-1,1,-1,2])

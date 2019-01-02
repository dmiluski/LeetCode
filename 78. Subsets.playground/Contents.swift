import Foundation
import Accelerate
/*
 78. Subsets
 
 Given a set of distinct integers, nums, return all possible subsets (the power set).
 
 Note: The solution set must not contain duplicate subsets.
 
 Example:
 
    Input: nums = [1,2,3]
    Output:
    [
        [3],
        [1],
        [2],
        [1,2,3],
        [1,3],
        [2,3],
        [1,2],
        []
    ]
 */

extension Array where Element: Comparable, Element: Hashable {
    // Separate each element from the rest of the elements
    var decomposeElements: [(element: Element, remaining: [Element])]? {
        guard !isEmpty else { return nil }
        
        var result:  [(element: Element, remaining: [Element])] = []
        
        var set = Set(self)
        for element in self {
            set.remove(element)
            result.append((element: element, remaining: Array(set)))
            set.insert(element)
        }
        
        return result
    }
    
    var subsets: [[Element]] {
        if let decomposed = decomposeElements {
            
            // Can this be done with a flatmap?
            var result = [[Element]]()
            decomposed.forEach { (element, remaining) in
                result.append([element])
                result.append(([element] + remaining).sorted())
                result += remaining.subsets
            }
            return result
        } else {
            return [[]]
        }
    }

}

// Problematic Approach
//
//  At first I spent some time considering permutations approach,
//  and splitting up decomposed values and constructing all subsets.
//
//  This was problematic as it created many duplicated set which grew
//  at an unreasonable rate. :(
class BadSolution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        return Array(Set(nums.subsets))
    }
}

// Rather than breaking up, use two loops to loop through option
// Time/Space Complexity: 2^n
class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var subsets: [[Int]] = []
        
        // Loop to cover starting at all values
        // Because it's a single direction, we won't have duplicates
        for (index, value) in nums.enumerated() {
            
            // Pair with existing values
            // Builds Pairs, Triplets, etc...
            for subvalue in subsets {
                var item = subvalue
                item.append(value)
                subsets.append(item)
            }
            
            // Include Individual Value
            subsets.append([nums[index]])
        }
        
        // Given the logic above is driven by count in subsets
        // Add this minimum result at the end.
        subsets.append([])

        return subsets
    }
}

// Tests


Solution().subsets([1,2,3,4,5,6,7]).count
//Solution().subsets([1,2,3,4,5,6,7])
//Solution().subsets([1,2,3,4,5,6,7,8,9,0])

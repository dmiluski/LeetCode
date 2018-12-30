//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
 Two Sum

 Given an array of integers, return indices of the two numbers such that they add up to a specific target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 */

// Approach:
//  "This" + "That" == "Sum"
//  Where That == Sum - This



// Big(O) == O(N^2)   :
//
//  Steps:
//      Loop through Items  O(n)
//          Inspect if matching item in array O(n)
struct Solution1 {
    func twoSum(_ nums: [Int], target: Int) -> (Int, Int)? {
        for (index, value) in nums.enumerated() {
            let pairValue = target - value
            if let pairIndex = nums.index(of: pairValue) {
                return (index, pairIndex)
            }
        }
        return nil
    }
}

// Big(O) == O(N)
//
//  Leverage extra Dictionary Storage for running scratch pad
struct Solution2 {
//    func twoSum(_ nums: [Int], target: Int) -> (Int, Int)? {
    func twoSum(_ nums: [Int], target: Int) -> [Int] {
        var dict:  [Int: Int] = [:] // [Value: Index]

        for (index, value) in nums.enumerated() {
            let pairValue = target - value
            if let pairIndex = dict[pairValue] {
                return [pairIndex, index]
            }
            dict[value] = index
        }
        return []
    }
}

// Solution 3 (Sort)
// Big(O) == O(n log n)
//  If already sorted, would be just O(log n)
//  So assume sorted for this particular endeavor
//
//  Approach:
//      Begin at edges and come towards the middle to find a sum which matches
//
//  Benefits: No Extra Storage
struct Solution3 {
    func twoSum(_ nums: [Int], target: Int) -> (Int, Int)? {

        var lowerIndex = 0
        var upperIndex = nums.count - 1

        while lowerIndex < upperIndex {
            let sum = nums[lowerIndex] + nums[upperIndex]

            if sum == target {
                return (lowerIndex, upperIndex)
            } else if sum < target {
                lowerIndex += 1
            } else {
                upperIndex -= 1
            }
        }

        return nil
    }
}


// Tests
let array = [2,7,11,15]

Solution1().twoSum(array, target: 9)
Solution2().twoSum(array, target: 9)
Solution3().twoSum(array, target: 9)


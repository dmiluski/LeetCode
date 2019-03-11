//: Playground - noun: a place where people can play

import UIKit

/**
 4. Median of Two Sorted Arrays
 Hard

 There are two sorted arrays nums1 and nums2 of size m and n respectively.

 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

 Example 1:
 nums1 = [1, 3]
 nums2 = [2]

 The median is 2.0
 Example 2:
 nums1 = [1, 2]
 nums2 = [3, 4]

 The median is (2 + 3)/2 = 2.5
 */



// Approach:
//  Performing a Binary Search a sorted array yields log(n) time
//
//  Given that, how do we find the medium?
//
//  Given Count Array 1 + Array 2
//
//  If Odd Count: Find individual Item
//  If Medium: Find Center Pairs, then divide by 2
//
//  How do we know we're in the middle?
//
//  Start in the middle of both arrays
//
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}


class Solution1 {

    /// Finds Median of two sorted arrays
    ///
    /// - Parameters:
    ///     - nums1: First ordered array
    ///     - nums2: Second ordered array
    /// - Note:
    ///     Brute force. Append Array, Sort, then find median (Center element)
    ///
    ///     Performance: O(n log(n)) due to sorting
    func findMedianSortedArraysViaMergeThenSort(_ nums1: [Int], _ nums2: [Int]) -> Double {

        //  Append Arrays, then sort
        //  Sort: O(n log(n))  (Quicksort)
        let array = (nums1 + nums2).sorted()
        guard array.count > 0 else { return 0 }

        switch array.count.isEven {
        case false:
            let index = (array.count / 2)
            return Double(array[index])
        case true:
            let index1 = (array.count / 2) - 1
            let index2 = (array.count / 2)
            return Double((array[index1] + array[index2])) / 2.0
        }
    }


    /// Finds Median of two sorted arrays
    ///
    /// - Parameters:
    ///     - nums1: First ordered array
    ///     - nums2: Second ordered array
    /// - Note:
    ///     Given we know arrays are sorted:
    ///     1. We know the count
    ///     2. We know we can iterate and take lower of two values to construct the sorted array
    ///
    ///     Performance: O(n) Given we're iterating through arrays once
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {

        let totalCount = nums1.count + nums2.count

        var nums1IteratingIndex: Int? = nums1.isEmpty ? nil : nums1.startIndex
        var nums2IteratingIndex: Int? = nums2.isEmpty ? nil : nums2.startIndex

        // Only construct Combined Array up to half the joined length
        let limitIndex = totalCount / 2
        var joinedArray = [Int](repeating: 0, count: limitIndex + 1)

        for index in 0...limitIndex {
            switch (nums1IteratingIndex, nums2IteratingIndex) {
            case let (nums1Index?, nums2Index?):
                if nums1[nums1Index] <= nums2[nums2Index] {
                    joinedArray[index] = nums1[nums1Index]
                    nums1IteratingIndex = nums1.index(nums1Index, offsetBy: 1, limitedBy: nums1.count - 1)
                } else {
                    joinedArray[index] = nums2[nums2Index]
                    nums2IteratingIndex = nums2.index(nums2Index, offsetBy: 1, limitedBy: nums2.count - 1)
                }

            case (let nums1Index?, nil):
                joinedArray[index] = nums1[nums1Index]
                nums1IteratingIndex = nums1.index(nums1Index, offsetBy: 1, limitedBy: nums1.count - 1)
            case (nil, let nums2Index?):
                joinedArray[index] = nums2[nums2Index]
                nums2IteratingIndex = nums2.index(nums2Index, offsetBy: 1, limitedBy: nums2.count - 1)
            default:
                fatalError()
            }

        }

        switch totalCount.isEven {
        case false:
            return Double(joinedArray[limitIndex])
        case true:
            return Double((joinedArray[limitIndex] + joinedArray[limitIndex - 1])) / 2.0
        }
    }
}

// Approach:
//  Use to runners to binary search and compare against each other

// Tests
Solution1().findMedianSortedArrays([1,2], [3,4]) == 2.5             // Even Total
Solution1().findMedianSortedArrays([1,2,3,4,5], [6,7,8,9]) == 5     // Odd Total
Solution1().findMedianSortedArrays([], [1,2,3,4,5,6,7,8,9]) == 5    // Single Empty


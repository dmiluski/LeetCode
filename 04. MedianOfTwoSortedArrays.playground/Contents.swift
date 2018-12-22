//: Playground - noun: a place where people can play

import UIKit

/*
 Problem 4

 Median of Two Sorted Arrays

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

// Approach:
//  Construct a Single Sorted Array
//
//  Append Arrays, Sort, Find Medium
class Solution1 {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {

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
}

// Approach:
//  Use to runners to binary search and compare against each other

// Tests
Solution1().findMedianSortedArrays([1,2], [3,4]) == 2.5             // Even Total
Solution1().findMedianSortedArrays([1,2,3,4,5], [6,7,8,9]) == 5     // Odd Total
Solution1().findMedianSortedArrays([], [1,2,3,4,5,6,7,8,9]) == 5    // Single Empty


//: Playground - noun: a place where people can play

import UIKit

/*
 11. Container With Most Water
 Medium

 Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.

 Note: You may not slant the container and n is at least 2.

 The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.

 Example:

 Input: [1,8,6,2,5,4,8,3,7]
 Output: 49
 */

class Solution {

    /**
     This is generally a difficult problem because we need to identify and measure not only the tallest,
     but also the items farthest away for total aread taken up by water.

     Given we know water must be bounded on two sides to be held, work our way from outside to in

     Approach:
     Use two pointers to identify the farthest away, calculate area, then work our way in re-evaluating
     for largest area
    */
    func maxArea(_ height: [Int]) -> Int {

        var lowerIndex = 0
        var upperIndex = height.endIndex - 1
        var maxArea = 0

        while lowerIndex < upperIndex {
            let width: Int = upperIndex - lowerIndex
            let localMinHeight: Int = min(height[lowerIndex], height[upperIndex])
            let area = localMinHeight * width

            maxArea = max(maxArea, area)

            if height[lowerIndex] < height[upperIndex] {
                lowerIndex += 1
            } else {
                upperIndex -= 1
            }
        }

        return maxArea
    }
}

// Tests:
Solution().maxArea([1,8,6,2,5,4,8,3,7])
Solution().maxArea([1,8,6,2,5,4,8,3,7]) == 49







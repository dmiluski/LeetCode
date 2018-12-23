import Foundation

/*
 42. Trapping Rain Water

 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.


 The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

 Example:

 Input: [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6

 */

/*
 Considerations:
 1. Either end can not hold water as it's not bounded on two sides
 2. Given a starting hight, the final raise can not exceed this hight or we're at a peak again

 v(x): Volume of X to count
 h(x): Height at position
 v(x) = min(lowerBoundPeak, upperBoundPeak) - h(x)

 Trapped water = reduce(into: 0, v(x))

 Because of the searching for lower/upper peaks for each location, this approach is O(n^2)



 Approach:
 Two runners:
    1. Identify the initial peak
    2. Identify initial peak - current => Sum
        If this sees another peak of equal or greater value, lock in sum, reset initial peak

        My require something of a function to determine final height to subtract from?

 Only Using only lowerBound approach misses local minimums
 Perhaps we can recurse on each new lowering? And take the larger of the two?

*/

//f(n) = min( h(n-1), h(n+1))
class Solution {

    // O(n^2) Approach
    // Create Models identifying peaks relative to each height
    // Why: This is working based on Height * Width
    func getPeaksFor(heights: [Int]) -> [(height: Int, peaks: (lowerPeak: Int, upperPeak: Int))] {
        var peaks = [(height: Int, peaks: (lowerPeak: Int, upperPeak: Int))]()

        // Iterate through set, to create Tuple of Height/Peaks for each value
        for (index, height) in heights.enumerated() {
            var lowerBoundPeak = 0
            var upperBoundPeak = 0


            // Search Collection for lower/upper peaks
            for (localIndex, localHeight) in heights.enumerated() {
                if localIndex < index {
                    lowerBoundPeak = max(lowerBoundPeak, localHeight)
                } else if localIndex > index {
                    upperBoundPeak = max(upperBoundPeak, localHeight)
                }
            }

            peaks.append((height: height, peaks: (lowerPeak: lowerBoundPeak, upperPeak: upperBoundPeak)))
        }
        return peaks
    }

    // Using O(n^2) approach above
    func slowTrap(_ heights: [Int]) -> Int {
        return getPeaksFor(heights: heights).reduce(into: 0) { (result, tuple) in
            result += max(0, min(tuple.peaks.lowerPeak, tuple.peaks.upperPeak) - tuple.height)
        }
    }

    // Can we do better
    // Perhaps we can leverage a running sum?
    // Rather than multiplaying, we can work with a lowerPeak/upper peak, and the diff from the sum
    // Performance: O(n)
    func trap(_ heights: [Int]) -> Int {

        guard var lowerRunnerIndex = heights.indices.first,
            var upperRunnerIndex = heights.indices.last else { return 0 }

        // Peak Trackers
        var lowerBoundPeak = 0
        var upperBoundPeak = 0

        // Running Sum
        var result = 0

        // By Appoarching from both ends, we gain context about potential peaks
        while lowerRunnerIndex <= upperRunnerIndex {

            if heights[lowerRunnerIndex] <= heights[upperRunnerIndex] {

                if heights[lowerRunnerIndex] >= lowerBoundPeak {
                    lowerBoundPeak = heights[lowerRunnerIndex]
                } else {
                    result += lowerBoundPeak - heights[lowerRunnerIndex]
                }
                lowerRunnerIndex += 1

            } else {

                if heights[upperRunnerIndex] >= upperBoundPeak {
                    upperBoundPeak = heights[upperRunnerIndex]
                } else {
                    result += upperBoundPeak - heights[upperRunnerIndex]
                }
                upperRunnerIndex -= 1

            }

        }
        return result
    }
}


// Tests
//                  1    1 2 1     1
Solution().trap([0,1,0,2,1,0,1,3,2,1,2,1]) == 6
//                  6           1     1
Solution().trap([11,1,7,6,5,4,3,2,3,2,0,1]) == 8

Solution().trap([3,2,1,2,3])
Solution().trap([4,3,4,5,6,7])
Solution().trap([1,2,3,4])
Solution().trap([0,5,5,4,5,5])
Solution().trap([5,5,4,5,5])
Solution().trap([5,5,4,4,5,5])
Solution().trap([1,2,3,2,1])





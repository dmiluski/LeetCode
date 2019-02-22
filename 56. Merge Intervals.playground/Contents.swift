import Foundation

/*
 56. Merge Intervals
 Medium

 Example 1:

 Input: [[1,3],[2,6],[8,10],[15,18]]
 Output: [[1,6],[8,10],[15,18]]
 Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].
 Example 2:

 Input: [[1,4],[4,5]]
 Output: [[1,5]]
 Explanation: Intervals [1,4] and [4,5] are considered overlapping.
 */


/**
 * Definition for an interval.
 */
// MARK: - Basic Model
public class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

// MARK: - Equatable Support
extension Interval: Equatable {
    public static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

// MARK: - Convenience Init
extension Interval {
    // Requires two value array
    convenience init?(interval: [Int]) {
        guard interval.count == 2 else { return nil }
        self.init(interval[0], interval[1])
    }
}

extension Interval: CustomStringConvertible {
    public var description: String {
        return "(\(start), \(end))"
    }
}

// MARK: - Range Helper
extension Interval {
    func range() -> ClosedRange<Int> {
        return start...end
    }
}

// MARK: - Collapse helper
extension Interval {
    // Collapses two intervals to include lowest start, and highest end
    func collapse(interval: Interval) -> Interval {
        let newStart = min(start, interval.start)
        let newEnd = max(end, interval.end)
        return Interval(newStart, newEnd)
    }
}

class Solution {
    /*
     Approach:
     Given ability to compare overlap, we are only responsible for
     joining Intervals given they overlap

     If we leverage a sort in increasing order, we can make a single iteration
     Rather than continuing to search the entire collection for a match.
     */
    func merge(_ intervals: [Interval]) -> [Interval] {

        var output: [Interval] = []
        let sortedIntervals = intervals
            .sorted { (lhs, rhs) -> Bool in
            return lhs.start < rhs.start
        }
        var currentBufferInterval: Interval?
        for interval in sortedIntervals {
            var stack = currentBufferInterval ?? interval

            // If Overlaps, update stackBuffer, otherwise append to output
            if stack
                .range()
                .overlaps(interval.range()) {
                stack = stack.collapse(interval: interval)

            } else {
                output.append(stack)
                stack = interval
            }
            currentBufferInterval = stack
        }

        // Last item
        if let item = currentBufferInterval {
            output.append(item)
        }

        return output
    }
}

// Test Mocks
let intervalBasic = [[1,2]].compactMap(Interval.init(interval:))
let intervals1 = [[1,3],[2,6],[8,10],[15,18]].compactMap(Interval.init(interval:))
let output1 = [[1,6],[8,10],[15,18]].compactMap(Interval.init(interval:))

let intervals2 = [[1,4],[4,5]].compactMap(Interval.init(interval:))
let output2 = [[1,5]].compactMap(Interval.init(interval:))

// Tests
Solution().merge(intervals1) == output1
Solution().merge(intervals2) == output2
Solution().merge(intervals2)

Solution().merge([Interval(1, 4),Interval(5, 7)])

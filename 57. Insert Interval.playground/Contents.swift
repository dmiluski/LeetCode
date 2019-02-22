import Foundation

/*
 57. Insert Interval
 Hard

 Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary).

 You may assume that the intervals were initially sorted according to their start times.

 Example 1:

 Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
 Output: [[1,5],[6,9]]
 Example 2:

 Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
 Output: [[1,2],[3,10],[12,16]]
 Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
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

     Given we have already solved a method to merge intervals, leverage existing merge
     but append a new interval, then merge
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

    func insert(_ intervals: [Interval], _ newInterval: Interval) -> [Interval] {
        return merge(intervals + [newInterval])
    }
}

// Tests
let intervals1 = [[1,3],[6,9]].compactMap(Interval.init(interval:))
let newInterval1 = Interval(2,5)
Solution().insert(intervals1, newInterval1)

let intervals2 = [[1,2],[3,5],[6,7],[8,10],[12,16]].compactMap(Interval.init(interval:))
let newInterval2 = Interval(4, 8)
Solution().insert(intervals2, newInterval2)

import Foundation

/*
 40. Combination Sum II

 Given a collection of candidate numbers (candidates) and a target number (target),
 find all unique combinations in candidates where the candidate numbers sums to target.

 Each number in candidates may only be used once in the combination.

 Note:

 All numbers (including target) will be positive integers.
 The solution set must not contain duplicate combinations.

 Example 1:

 Input: candidates = [10,1,2,7,6,1,5], target = 8,
 A solution set is:
    [
        [1, 7],
        [1, 2, 5],
        [2, 6],
        [1, 1, 6]
    ]

 Example 2:

 Input: candidates = [2,5,2,1,2], target = 5,
 A solution set is:
    [
        [1,2,2],
        [5]
    ]
 */


/*
 Approach:
 Model havily off of 39 (sum), but differ in that we don't reuse an item
 */
enum Result<T> {
    case success(T)
    case failure
}

typealias Model = Result<[[Int]]>

class Solution {
    private func insert(result: [[Int]],  to model: inout [[Int]], for candidate: Int) {
        var arrays = [[Int]]()

        for array in result {
            arrays.append(([candidate] + array).sorted())
        }

        if arrays.isEmpty {
            arrays.append([candidate])
        }

        model += arrays
    }

    private func recurseCominationSum(candidates: [Int], target: Int) -> Model {

        // Sentinal Success (Match)
        guard target != 0 else {
            return Model.success([[Int]]())
        }

        // Sentinal Failure
        guard !candidates.isEmpty,
            target > 0 else {
                return .failure
        }

        var results = [[Int]]()

        for (index, candidate) in candidates.enumerated() {
            let newTarget = target - candidate


            var candidateResults = [[Int]]()

            // Remove current Item
            var arrayWithoutCandidate = candidates
            arrayWithoutCandidate.remove(at: index)


            if case let .success(result) = recurseCominationSum(candidates: arrayWithoutCandidate, target: newTarget) {
                insert(result: result, to: &candidateResults, for: candidate)
            }

            results += candidateResults
        }

        // Unique Results:
        results = Array(Set(results))

        if !results.isEmpty {
            return Model.success(results)
        } else {
            return Model.failure
        }
    }

    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        switch recurseCominationSum(candidates: candidates, target: target) {
        case let .success(result):
            return result
        case .failure:
            return [[Int]]()
        }    }
}

Solution().combinationSum2([10,1,2,7,6,1,5], 8)
print(Solution().combinationSum2([10,1,2,7,6,1,5], 8))

Solution().combinationSum2([2,5,2,1,2],5)
print(Solution().combinationSum2([2,5,2,1,2],5))

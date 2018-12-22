import Foundation

/*
 39. Combination Sum

 Given a set of candidate numbers (candidates) (without duplicates) and a target number (target),
 find all unique combinations in candidates where the candidate numbers sums to target.

 The same repeated number may be chosen from candidates unlimited number of times.

 Note:

 All numbers (including target) will be positive integers.
 The solution set must not contain duplicate combinations.

 Example 1:

    Input: candidates = [2,3,6,7], target = 7,
    A solution set is:
    [
        [7],
        [2,2,3]
    ]
 Example 2:

    Input: candidates = [2,3,5], target = 8,
    A solution set is:
    [
        [2,2,2,2],
        [2,3,3],
        [3,5]
    ]
 */


/*
 Goals:
    Give the unlimited nature, this is looking like a potential recusive problem trying self
    And iterating through each option.

    Things to consider:
    Would sorting provide any benefit?
    Consider Unique combinations? Store output in a set for easy uniquing?

 PseudoCode:
    For Each Digit, attempt to recurse to find permutation sum including self, as well as not including self
 */


enum Result<T> {
    case success(T)
    case failure
}

typealias Model = Result<[[Int]]>

class Solution {

    // Require Sorted Low to high

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

        for candidate in candidates {
            let newTarget = target - candidate


            var candidateResults = [[Int]]()

            // Include candidate
            if case let .success(result) = recurseCominationSum(candidates: candidates, target: newTarget) {
                insert(result: result, to: &candidateResults, for: candidate)
            }


            // Exlude candidate before current
            var set = Set(candidates)
            set.remove(candidate)
            let arrayExcludingCandidate = Array(set)

            if case let .success(result) = recurseCominationSum(candidates: arrayExcludingCandidate, target: newTarget) {
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

    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        switch recurseCominationSum(candidates: candidates, target: target) {
        case let .success(result):
            return result
        case .failure:
            return [[Int]]()
        }
    }
}

Solution().combinationSum([2,3,6,7], 7)
print(Solution().combinationSum([2,3,6,7], 7))

print(Solution().combinationSum([2,3,5], 8))

import Foundation
/*
 691. Stickers to Spell Word
 Hard

 We are given N different types of stickers. Each sticker has a lowercase English word on it.

 You would like to spell out the given target string by cutting individual letters from your collection of stickers and rearranging them.

 You can use each sticker more than once if you want, and you have infinite quantities of each sticker.

 What is the minimum number of stickers that you need to spell out the target? If the task is impossible, return -1.

 Example 1:

 Input:

 ["with", "example", "science"], "thehat"
 Output:

 3
 Explanation:

 We can use 2 "with" stickers, and 1 "example" sticker.
 After cutting and rearrange the letters of those stickers, we can form the target "thehat".
 Also, this is the minimum number of stickers necessary to form the target string.
 Example 2:

 Input:

 ["notice", "possible"], "basicbasic"
 Output:

 -1
 Explanation:

 We can't form the target "basicbasic" from cutting letters from the given stickers.
 Note:

 stickers has length in the range [1, 50].
 stickers consists of lowercase English words (without apostrophes).
 target has length in the range [1, 15], and consists of lowercase English letters.
 In all test cases, all words were chosen randomly from the 1000 most common US English words, and the target was chosen as a concatenation of two random words.
 The time limit may be more challenging than usual. It is expected that a 50 sticker test case can be solved within 35ms on average.
 */


// Approach / Considerations:
//
//  Notable DataPoints:
//  Can use each sticker an infinite number of times, meaning as long as all stickers contain each letter at least once
//  then it is solvable. We can use this to quickly determine solvability with CharacterSet's functionality of isSubset
//
//  Once we know it's solvable with that simple check, we can then inspect how we can break down sticker -> solution
//
//  Similar to 383. Ransom note, we may be able to create a dictionary lookup to search out relavent stickers
//
extension String {

    /// Dictionary of each character within string and it's count
    ///
    /// - Performance: O(n)
    var characterCounts: [Character: Int] {
        var dictionary = [Character: Int]()
        dictionary.reserveCapacity(count)

        for character in self {
            dictionary[character] = (dictionary[character] ?? 0) + 1
        }

        return dictionary
    }
}

extension Dictionary where Key == Character, Value == Int {

    /// Difference between Dictionary Key/Values
    ///
    /// - Parameters:
    ///     - dict: Dict to subtract from
    ///
    /// - Returns: Result Dictionary containing difference.
    ///            Counts lower than one are removed from the Dictionary
    ///
    /// - Note: Performance: O(n)
    func subtracting(dict: [Key: Value]) -> [Key: Value] {
        var output = [Key: Value]()

        forEach { (keyValue) in
            let (key, value) = keyValue
            let newCount = value - (dict[key] ?? 0)

            if newCount > 0 {
                output[key] = newCount
            }
        }
        return output
    }
}

class Solution {


    /// Recursively inspect Min Stickers (Stickers can be used > 1)
    ///
    /// - Parameters:
    ///     - stickers: Array of [Character: Count] lookup dictionary
    ///     - target: [Character: Count] model lookup dictionary
    ///     - memoizedMode: For speed and reduced duplication of lookups
    ///
    /// - Returns: Minimum number of stickers required to construct target
    ///
    /// - Note:
    ///     Requires that stickers must be able to solve target
    private func recurseMinSticker(stickers: [[Character: Int]],
                                   target: [Character: Int],
                                memoizedModel: inout [[Character: Int]: Int]) -> Int {

        // Memoized Sentinel Check - Already Calculated
        if let priorCalculation = memoizedModel[target] {
            return priorCalculation
        }

        // Sentinel - Success, reached the end
        guard let first = target.first else { return 0 }

        // Determine how many times the character is present
        var firstCharCount = 0
        for character in target {
            if character == first {
                firstCharCount += 1
            } else {
                break
            }
        }

        // Fork the positiblities
        // Inspect full word for matches O(n)
        let stickerCounts = stickers.compactMap { (mappingDict) -> Int? in
            // Subtract out matching Portions
            let remaining = target.subtracting(dict: mappingDict)

            // If no difference don't recurse
            guard remaining != target else { return nil }

            let recursedValue = recurseMinSticker(stickers: stickers,
                                                  target: remaining,
                                                  memoizedModel: &memoizedModel)

            guard recursedValue >= 0 else { return nil }
            return recursedValue + 1
        }

        let minStickerCount = stickerCounts.min() ?? -1

        // Update Memoized Model
        memoizedModel[target] = minStickerCount


        return minStickerCount
    }

    func minStickers(_ stickers: [String], _ target: String) -> Int {

        // Check first if solvable
        let stickerStringsCharacterSet = CharacterSet(charactersIn: stickers.joined())
        let targetCharacterSet = CharacterSet(charactersIn: target)

        // If not a subset, not solvable
        guard targetCharacterSet.isSubset(of: stickerStringsCharacterSet) else { return -1 }

        // Given we know it's solvable, construct data model to assist in counting stickers
        let stickerCharCountDictionaries = stickers.map({ $0.characterCounts })
        let targetCharCountDictionary = target.characterCounts

        var memoizedModel = [[Character: Int]: Int]()
        return recurseMinSticker(stickers: stickerCharCountDictionaries,
                                 target: targetCharCountDictionary,
                                 memoizedModel: &memoizedModel)

    }
}

// Tests:
Solution().minStickers(["with", "example", "science"], "thehat") == 3
Solution().minStickers(["notice", "possible"], "basicbasic") == -1
Solution().minStickers(["a","enemy","material","whose","twenty","describe","magnet","put","hundred","discuss"], "separatewhich")


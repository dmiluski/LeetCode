import Foundation
/*
 383. Ransom Note

 Given an arbitrary ransom note string and another string containing letters from all the magazines, write a function that will return true if the ransom note can be constructed from the magazines ; otherwise, it will return false.

 Each letter in the magazine string can only be used once in your ransom note.

 Note:
 You may assume that both strings contain only lowercase letters.

 canConstruct("a", "b") -> false
 canConstruct("aa", "ab") -> false
 canConstruct("aa", "aab") -> true
 */

class Solution {

    // Approaches:
    //  At first though, this looks very similar to a subset problem. A notable constraint which prevents this
    //  approach is each letter of the magazine can only be used once, which limits CharacterSet.isSubset check.
    //  This means we're not going to get away with an O(1) lookup once data structure is setup.
    //
    //  Given the problem mentions nowthing about sorting, if we iterate without a sort each character check
    //  would yield O(n^2) lookups which would perform quite poorly.
    //
    //  If we are not limited by space, we can create two separate arrays and sort, then iterate through each.
    //
    //  Expected Performance:
    //      Initial Sort: O(Nlog(n)) + Iterate and compare: O(N) -> O(N log(n))
    //      Space Complexity: O(N) relative to space of both ransomNote and magazing
    //
    //
    //  Yet another alternative would be to create a dictionary lookup of character counts
    //  This would take O(n) to construct, then O(n) to determin if the magazine contains the lookup

    /// Determines if ransomNote is a subset of magazine
    ///
    /// - Parameters:
    ///     - ransomNote: String to compare as subset of magazine
    ///     - magazine: String to be campared against to see if it contains all of the ransomNote letters
    ///
    /// - Returns: Boolean whether or not the ransomNote can be constructed from the magazine
    /// - Note: This performans at O(n log(n)) due to a sort
    func canConstructSlowish(_ ransomNote: String, _ magazine: String) -> Bool {



        // Sort Inputs for faster comparison
        var sortedRansomNote = ransomNote.sorted()
        var sortedMagazine = magazine.sorted()


        // Iterate Inputs comparing
        var ransomNoteIteratingIndex = sortedRansomNote.startIndex
        var magazineIteratingIndex = sortedMagazine.startIndex

        // Loop until end of either inputs
        while ransomNoteIteratingIndex < sortedRansomNote.count,
            magazineIteratingIndex < sortedMagazine.count {

                // Compare Potential Cases
                //  - Equality
                //  - Less Than
                //  - Greater Than
                switch sortedRansomNote[ransomNoteIteratingIndex] {

                // Equality - Move Both Ransom and Index Index Forward
                case let value where value == sortedMagazine[magazineIteratingIndex]:

                    ransomNoteIteratingIndex = sortedRansomNote.index(after: ransomNoteIteratingIndex)
                    magazineIteratingIndex = sortedMagazine.index(after: magazineIteratingIndex)

                // Less Than - No Chance will be found in Magazine - Fail case
                case let value where value < sortedMagazine[magazineIteratingIndex]:

                    // Update index to end to fail next while loop check
                    magazineIteratingIndex = sortedMagazine.endIndex

                // Greater Than - Move Magazine Index Forward
                case let value where value > sortedMagazine[magazineIteratingIndex]:

                    magazineIteratingIndex = sortedMagazine.index(after: magazineIteratingIndex)


                default:
                    fatalError("Given value is comparable, this use case should never be reached")
                    break
                }

        }

        return ransomNoteIteratingIndex == sortedRansomNote.endIndex
    }

    /// Determines if ransomNote is a subset of magazine
    ///
    /// - Parameters:
    ///     - ransomNote: String to compare as subset of magazine
    ///     - magazine: String to be campared against to see if it contains all of the ransomNote letters
    ///
    /// - Returns: Boolean whether or not the ransomNote can be constructed from the magazine
    /// - Note: This Performs at O(n) given construction of dictionary lookup O(n), then another O(n) check
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {

        // Cache model to inspect counts of characters available
        var dictionaryLookup: [Character: Int] = {
            var dictionary = [Character: Int]()
            dictionary.reserveCapacity(magazine.count)

            for character in magazine {
                dictionary[character] = (dictionary[character] ?? 0) + 1
            }

            return dictionary
        }()

        var success = true
        for character in ransomNote {
            let countOfCharacterAvailable = dictionaryLookup[character] ?? 0
            guard countOfCharacterAvailable > 0 else {
                success = false
                break
            }
            dictionaryLookup[character] = countOfCharacterAvailable - 1
        }

        return success
    }
}

//Solution().canConstruct("a", "b") == false
//Solution().canConstruct("aa", "ab") == false
//Solution().canConstruct("aa", "aab") == true
//Solution().canConstruct("aabbcc", "bbccaa")
Solution().canConstruct("bgzyr", "efjbdfbdgfjhhaiigfhbaejahgfbbgbjagbddfgdiaigdadhcfcj")

import Foundation

/*
 30. Substring with Concatenation of All Words

 You are given a string, s, and a list of words, words, that are all of the same length.

 Find all starting indices of substring(s) in s that is a concatenation of each word in words exactly once and
 without any intervening characters.

 Example 1:

 Input:
 s = "barfoothefoobarman",
 words = ["foo","bar"]
 Output: [0,9]
 Explanation: Substrings starting at index 0 and 9 are "barfoor" and "foobar" respectively.
 The output order does not matter, returning [9,0] is fine too.
 Example 2:

 Input:
 s = "wordgoodgoodgoodbestword",
 words = ["word","good","best","word"]
 Output: []
 */

extension String {
    var fullRange: Range<String.Index> {
        return Range<String.Index>(uncheckedBounds: (lower: startIndex, upper: endIndex))
    }

    func chunked(by k: Int) -> [String] {
        let characters = Array(self)
        return stride(from: 0, to: characters.count, by: k).map {
            String(characters[$0..<min($0 + k, characters.count)])
        }
    }
}

/*
 Reference Blog: https://www.objc.io/blog/2014/12/08/functional-snippet-10-permutations/

 Approach:
 1. Decompose: Separate first element from the rest of the array
 This allows us to setup
 2. Recurse to custruct Permutation Tree of Options
 3.

 */
extension Array {
    /**
     Decompose the first element of an array from its suffix subcollection
     */
    var decompose: (head: Element, remaining: [Element])? {
        guard let first = self.first else { return nil }
        return (first, Array(self[1..<count]))
    }

    /**
     Decompose and Construct PermutationTree (walk each option and map to an array output)
     */
    ///
    var permutations: [[Element]] {
        if let (head, suffix) = decompose {
            return suffix.permutations.flatMap({ return between(x: head, ys: $0)})
        } else {
            return [[]]
        }
    }
}

/**
 Creates all possibilities of x placements in array

 - Parameters:
 - x: The element to place in each possible position
 - ys: Array of which we want to place x in each possible position

 - Returns: Array of Arrays where (x) is placed in each possible position of array (ys)
 */
func between<T>(x: T, ys: [T]) -> [[T]] {
    guard let (head, suffix) = ys.decompose else { return [[x]] }

    // Construct Response using current ordered item, followed by collection item(x) in each position
    return [[x] + ys] + between(x: x, ys: suffix).map({ [head] + $0 })
}

class Solution {

    /// Finds Starting index for each possible permutation starting point
    ///
    /// - Requirement: All words are of same length, no duplicate words
    ///
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {

        guard let first = words.first else { return [] }

        // Output: Starting Indexes of permutation Matches
        var indexes: [Int] = []

        // Loop Models
        let individualWordLength = first.count
        let fullWordLength = individualWordLength * words.count

        // Generate all Permutations of words
        // This will be used to compare against s subranges
        let wordPermutations = words
            .permutations
            .map({$0.joined()} )

        for permutation in wordPermutations {

            var offSetsOfFirstCharacters: [Int] = []
            for (index, value) in s.enumerated() {
                if value == permutation.first {
                    offSetsOfFirstCharacters.append(index)
                }
            }

            // Loop - Compare permutations to word offsets
            //
            // Initial Attempt offset by one each time and compared.
            // The performance was poor due to testing against known fail cases
            //
            // Instead, seek out the next index for starting character
            var offsetIterator = offSetsOfFirstCharacters.makeIterator()
            while let offset = offsetIterator.next(),
                let beginning = s.index(s.startIndex, offsetBy: offset, limitedBy: s.endIndex),
                let ending = s.index(beginning, offsetBy: fullWordLength, limitedBy: s.endIndex) {

                    let substring = s[beginning..<ending]
                    if permutation == substring {
                        indexes.append(offset)
                    }
            }
        }

        // Only Unique Values
        return Array(Set(indexes))
    }
}

// Tests:
Solution().findSubstring("barfoothefoobarman", ["foo","bar"])
Solution().findSubstring("wordgoodgoodgoodbestword", ["word","good","best","word"])

// Expected: [13]
// "lingmindraboo fooowingdingbarrwing monkeypoundcake",
Solution().findSubstring(
    "lingmindraboofooowingdingbarrwingmonkeypoundcake",
    [
        "fooo",
        "barr",
        "wing",
        "ding",
        "wing"
    ]
)

// Use case that breaks test:
/*(
"pjzkrkevzztxductzzxmxsvwjkxpvukmfjywwetvfnujhweiybwvvsrfequzkhossmootkmyxgjgfordrpapjuunmqnxxdrqrfgkrsjqbszgiqlcfnrpjlcwdrvbumtotzylshdvccdmsqoadfrpsvnwpizlwszrtyclhgilklydbmfhuywotjmktnwrfvizvnmfvvqfiokkdprznnnjycttprkxpuykhmpchiksyucbmtabiqkisgbhxngmhezrrqvayfsxauampdpxtafniiwfvdufhtwajrbkxtjzqjnfocdhekumttuqwovfjrgulhekcpjszyynadxhnttgmnxkduqmmyhzfnjhducesctufqbumxbamalqudeibljgbspeotkgvddcwgxidaiqcvgwykhbysjzlzfbupkqunuqtraxrlptivshhbihtsigtpipguhbhctcvubnhqipncyxfjebdnjyetnlnvmuxhzsdahkrscewabejifmxombiamxvauuitoltyymsarqcuuoezcbqpdaprxmsrickwpgwpsoplhugbikbkotzrtqkscekkgwjycfnvwfgdzogjzjvpcvixnsqsxacfwndzvrwrycwxrcismdhqapoojegggkocyrdtkzmiekhxoppctytvphjynrhtcvxcobxbcjjivtfjiwmduhzjokkbctweqtigwfhzorjlkpuuliaipbtfldinyetoybvugevwvhhhweejogrghllsouipabfafcxnhukcbtmxzshoyyufjhzadhrelweszbfgwpkzlwxkogyogutscvuhcllphshivnoteztpxsaoaacgxyaztuixhunrowzljqfqrahosheukhahhbiaxqzfmmwcjxountkevsvpbzjnilwpoermxrtlfroqoclexxisrdhvfsindffslyekrzwzqkpeocilatftymodgztjgybtyheqgcpwogdcjlnlesefgvimwbxcbzvaibspdjnrpqtyeilkcspknyylbwndvkffmzuriilxagyerjptbgeqgebiaqnvdubrtxibhvakcyotkfonmseszhczapxdlauexehhaireihxsplgdgmxfvaevrbadbwjbdrkfbbjjkgcztkcbwagtcnrtqryuqixtzhaakjlurnumzyovawrcjiwabuwretmdamfkxrgqgcdgbrdbnugzecbgyxxdqmisaqcyjkqrntxqmdrczxbebemcblftxplafnyoxqimkhcykwamvdsxjezkpgdpvopddptdfbprjustquhlazkjfluxrzopqdstulybnqvyknrchbphcarknnhhovweaqawdyxsqsqahkepluypwrzjegqtdoxfgzdkydeoxvrfhxusrujnmjzqrrlxglcmkiykldbiasnhrjbjekystzilrwkzhontwmehrfsrzfaqrbbxncphbzuuxeteshyrveamjsfiaharkcqxefghgceeixkdgkuboupxnwhnfigpkwnqdvzlydpidcljmflbccarbiegsmweklwngvygbqpescpeichmfidgsjmkvkofvkuehsmkkbocgejoiqcnafvuokelwuqsgkyoekaroptuvekfvmtxtqshcwsztkrzwrpabqrrhnlerxjojemcxel"
["dhvf","sind","ffsl","yekr","zwzq","kpeo","cila","tfty","modg","ztjg","ybty","heqg","cpwo","gdcj","lnle","sefg","vimw","bxcb"]
*/
//
//
//let words = ["dhvf","sind","ffsl","yekr","zwzq","kpeo","cila","tfty","modg","ztjg","ybty","heqg","cpwo","gdcj","lnle","sefg","vimw","bxcb"]
//
//let rec: [String: Int] = words.reduce(into: [:]) { $0[$1] = $0[$1] == nil ? 1 : $0[$1]! + 1 }
//print(rec.values)

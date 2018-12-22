import Foundation

/*
 38. Count and Say

 The count-and-say sequence is the sequence of integers with the first five terms as following:

 1.     1
 2.     11
 3.     21
 4.     1211
 5.     111221
 1 is read off as "one 1" or 11.
 11 is read off as "two 1s" or 21.
 21 is read off as "one 2, then one 1" or 1211.

 Given an integer n where 1 ≤ n ≤ 30, generate the nth term of the count-and-say sequence.

 Note: Each term of the sequence of integers will be represented as a string.



 Example 1:

 Input: 1
 Output: "1"
 Example 2:

 Input: 4
 Output: "1211"
 */


/*
 Goals:
 - [x] Create Sequence 1...30
    Sequence(n) = DescriptionOf(Sequence(n-1))

 - [x] Impement Description
        Identify EqualCharacters after?

        PseudoCode:
            Scan
            if current != previous
                create Dict[Int: Count]
            if current = previous
                increment count

            Once reached the end, construct the new number with [Key + Value]s

 - [x] Access nth term
 - [x] Test on larger nth values
 */

extension Int {
    /// Returns Current Int as an array of it's individual decimal characters
    //  eg. 1234 -> [1,2,3,4]
    //  eg  1    -> [1]
    //  eg  0    -> []
    //
    // Currently only support Positive Numbers
    func toArray() -> [Int] {
        var remainder = self
        var array: [Int] = []

        while remainder > 0 {
            array.append(remainder % 10)
            remainder = remainder / 10
        }
        return Array(array.reversed())
    }
}

extension String {
    // Extracts Integer characters to an array
    func toIntArray() -> [Int] {
        var array: [Int] = []

        for character in Array(self) {
            if let value = Int(String(character)) {
                array.append(Int(value))
            }
        }
        return array
    }
}


struct Model {
    let value: Int
    let count: Int

    // Count of Values
    var description: String {
        return String(count) + String(value)
    }
}

struct CountAndSayDescription {
    let value: String
}

extension CountAndSayDescription {
    init(array: [Int]) {


        var modelIndex = 0
        var models: [Model] = []

        for (index, value) in array.enumerated() {
            if index > 0 {
                let model = models[modelIndex]

                // Compare against previous index
                if model.value == value {
                    models[modelIndex] = Model(value: value, count: model.count + 1)
                } else {
                    models.append(Model(value: value, count: 1))
                    modelIndex += 1
                }

            } else {
                models.append(Model(value: value, count: 1))
            }
        }

        let description = models
            .map({ $0.description })
            .joined()

        self.init(value: description)
    }
}

struct CountAndSaySequence {
    let nth: Int
    let value: String
}

extension CountAndSaySequence {
    init(nth: Int) {
        self.nth = nth

        guard nth > 1 else {
            self.value = "1"
            return
        }

        let array = CountAndSaySequence(nth: nth - 1).value.toIntArray()
        self.value = CountAndSayDescription(array: array).value
    }
}

class Solution {
    func countAndSay(_ n: Int) -> String {
        return CountAndSaySequence(nth: n).value
    }
}

// Tests
Solution().countAndSay(1) == "1"
Solution().countAndSay(4) == "1211"

// While testing, found initial implementation broke due to Integer Size restrictions
// Moved to Handle as strings/arrays, and limit Integer for individual character references
Solution().countAndSay(10)
Solution().countAndSay(30)

import Foundation

/*
 23. Merge K Sorted Lists

 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

 Example:

 Input:
 [
 1->4->5,
 1->3->4,
 2->6
 ]
 Output: 1->1->2->3->4->4->5->6
 */

class ListNode: CustomStringConvertible {
    var value: Int
    var next: ListNode?

    init(_ value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }

    var description: String {
        return "\(value) -> \(next?.description ?? "nil")"
    }

    // Init List from literal Array
    convenience init?(values: [Int]) {
        guard let value = values.first else { return nil }
        let next = ListNode(values: Array(values.suffix(from: 1)))
        self.init(value, next: next)
    }
}

// MARK: - Sorting

extension ListNode {
    static func increasingOrder(lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.value < rhs.value
    }
}

class Solution {
    // Given Sorted Lists
    // Merges to a single sorted List
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var unemptyLists = lists.compactMap({ $0 })

        // Find MinValue O(n) [ We must have a minimum value at this point ]
        guard let minNode = unemptyLists.min(by: ListNode.increasingOrder),
            let index = unemptyLists.firstIndex(where: {$0.value == minNode.value }) else { return nil }

        let min = unemptyLists.remove(at: index)

        if let next = min.next {
            unemptyLists.append(next)
        }

        min.next = mergeKLists(unemptyLists)
        return min
    }
}

// Test Mocks
extension ListNode {
    static func input1() -> ListNode? {
        return ListNode(values: [1,4,5])
    }

    static func input2() -> ListNode? {
        return ListNode(values: [1,3,4])
    }

    static func input3() -> ListNode? {
        return ListNode(values: [2,6])
    }

    static func output() -> ListNode? {
        return ListNode(values: [1,1,2,3,4,4,5,6])
    }
}

/*
 1->4->5,
 1->3->4,
 2->6
 ]
 Output: 1->1->2->3->4->4->5->6
 */
print(Solution().mergeKLists([ListNode.input1(), ListNode.input2(), ListNode.input3()]))
Solution().mergeKLists([ListNode.input1(), ListNode.input2(), ListNode.input3()])?.description == ListNode.output()?.description

import Foundation

/*
 21. Merge Two Sorted Lists

 Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

 Example:

 Input: 1->2->4, 1->3->4
 Output: 1->1->2->3->4->4
 */

// MARK: - ListNode Basic Model

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

// MARK: - Merge Support (Requires to be Ordered)

extension ListNode {
    // Work with Two Lists (Requires Two Ordered Lists
    func merged(node: ListNode?) -> ListNode {
        guard let node = node else { return self }

        // When to update pointers
        if value <= node.value {
            next = next?.merged(node: node) ?? node
            return self
        } else {
            return node.merged(node: self)
        }
    }
}

// MARK: - Test Data

extension ListNode {
    static func input1() -> ListNode? {
        return ListNode(values: [1,2,4])
    }

    static func input2() -> ListNode? {
        return ListNode(values: [1,3,4])
    }

    static func output() -> ListNode? {
        return ListNode(values: [1,1,2,3,4,4])
    }
}

class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return l1?.merged(node: l2) ?? l2?.merged(node: l1)
    }
}

// Tests
Solution().mergeTwoLists(ListNode.input1(), ListNode.input2())?.description == ListNode.output()?.description
Solution().mergeTwoLists(ListNode.input1(), ListNode.input2())
Solution().mergeTwoLists(ListNode.input1(), nil)
Solution().mergeTwoLists(nil, ListNode.input2())



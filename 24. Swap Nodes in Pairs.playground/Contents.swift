import Foundation

/*
 23. Swap Nodes in Pairs

 Given a linked list, swap every two adjacent nodes and return its head.

 Example:

 Given 1->2->3->4, you should return the list as 2->1->4->3.
 Note:

 Your algorithm should use only constant extra space.
 You may not modify the values in the list's nodes, only nodes itself may be changed.
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

extension Int {
    var isEven: Bool  {
        switch self % 2 {
        case 0: // Even (Pair to Swap)
            return true
        case 1: // Odd (Don't Swap)
            return false
        default:
            fatalError()
        }
    }
}

// MARK: - Sorting

class Solution {
    // Complexities:
    // - Linked list doesn't know size up from, so likely need to recurse to end
    // - Only affect pairs which means there needs to be "some" context"

    // Keep Track of Count (K from end) Use Modulo to determine the need for swap?
    // Who keeps track of the pointer changes
    func swapPairs(node: ListNode?, position: Int) -> ListNode? {
        // Sanitize / Sentinal Check
        guard let node = node else { return nil }

        let item = swapPairs(node: node.next, position: position + 1)
        switch !position.isEven {
        case true: // Odd (Pair to Swap)

            let temp = item?.next
            node.next = temp
            item?.next = node
            return item ?? node

        case false: // Even  (Don't Swap, but update next reference to response)
            node.next = item
            return node
        }

    }

    func swapPairs(_ head: ListNode?) -> ListNode? {
        return swapPairs(node: head, position: 1)
    }
}

// Test Mocks
extension ListNode {
    static func input() -> ListNode? {
        return ListNode(values: [1,2,3,4])
    }

    static func output() -> ListNode? {
        return ListNode(values: [2,1,4,3])
    }

    static func oddInput() -> ListNode? {
        return ListNode(values:[1,2,3,4,5,6])
    }

    static func oddOutput() -> ListNode? {
        return ListNode(values:[2,1,4,3,6,5])
    }
}

// Tests
Solution().swapPairs(ListNode.input())
Solution().swapPairs(ListNode.input())?.description == ListNode.output()?.description

Solution().swapPairs(ListNode.oddInput())
Solution().swapPairs(ListNode.oddInput())?.description == ListNode.oddOutput()?.description

Solution().swapPairs(ListNode(values: [1,2,3]))
Solution().swapPairs(ListNode(values: [1,2,3,4,5]))

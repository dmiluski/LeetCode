//: Playground - noun: a place where people can play

import Foundation


/*
 19. Remove Nth Node From End of List

 Given a linked list, remove the n-th node from the end of list and return its head.

 Example:

 Given linked list: 1->2->3->4->5, and n = 2.

 After removing the second node from the end, the linked list becomes 1->2->3->5.
 Note:

 Given n will always be valid.
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

extension ListNode {
    // Default list
    static func mock() -> ListNode? {
        return ListNode(values: [1,2,3,4,5])
    }
}

class Solution {
    // Goal:
    // 1. Identify element in position Node(end - N)
    // 2. Update Node[end - N - 1] to reference Node[end - N + 1]
    //
    // Difficulties:
    //  Must visit end, to identify node satisfying offset from end
    //
    // What information is useful?
    // - Current Position
    // - Count Nodes behind
    // What makes this painful to identify (Nth from end, which means we need to visit the end to determine
    // What information is useful here? Current position vs expected item to remove?
    //

    // Offset - From the beginning
    // Offset - From end?
    // Goal, determine how far I am from end
    // This format is returning a node? Which is useful when adding next? But what if we returned a tuple? (Node + Offset)
    func recurseRemoveNthFromEnd(head: ListNode?, indexFromEnd: Int) -> (node: ListNode?, currentIndex: Int) {

        // Sentinal Identifying End (Nil)
        guard let node = head else { return (head, 0) }

        // Given we have a next Recurse to find end
        let tuple = recurseRemoveNthFromEnd(head: node.next, indexFromEnd: indexFromEnd)

        // Identify Node For Removal
        let newHead: ListNode?
        if tuple.currentIndex + 1 == indexFromEnd {

            // Remove current node from response
            newHead = node.next
        } else {
            newHead = node
            newHead?.next = tuple.node
        }

        // Recursively update next references to inherit new next node
        return (newHead, tuple.currentIndex + 1)
    }
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        return recurseRemoveNthFromEnd(head: head, indexFromEnd: n).node
    }
}

// Tests:
/*
 Given linked list: 1->2->3->4->5, and n = 2.

 After removing the second node from the end, the linked list becomes 1->2->3->5.
 */
Solution().removeNthFromEnd(ListNode.mock(), 1)?.description == "1 -> 2 -> 3 -> 4 -> nil"
Solution().removeNthFromEnd(ListNode.mock(), 2)?.description == "1 -> 2 -> 3 -> 5 -> nil"
Solution().removeNthFromEnd(ListNode.mock(), 3)?.description == "1 -> 2 -> 4 -> 5 -> nil"
Solution().removeNthFromEnd(ListNode.mock(), 4)?.description == "1 -> 3 -> 4 -> 5 -> nil"
Solution().removeNthFromEnd(ListNode.mock(), 5)?.description == "2 -> 3 -> -> 4 -> 5 -> nil"

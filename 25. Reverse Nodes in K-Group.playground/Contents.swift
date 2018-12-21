import Foundation

/*
 23. Reverse Nodes in k-Group

 Given a linked list, reverse the nodes of a linked list k at a time and return its modified list.

 k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes in the end should remain as it is.

 Example:

 Given this linked list: 1->2->3->4->5

 For k = 2, you should return: 2->1->4->3->5

 For k = 3, you should return: 3->2->1->4->5

 Note:

 Only constant extra memory is allowed.
 You may not alter the values in the list's nodes, only nodes itself may be changed.
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
    func append(node: ListNode?) {
        var tail: ListNode = self
        while let next = tail.next {
            tail = next
        }
        tail.next = node
    }

    // O(n)
    var count: Int {
        return 1 + (next?.count ?? 0)
    }

    private func hasMoreChildrenThan(k: UInt, currentCount: UInt) -> Bool {
        guard currentCount < k else {
            return true
        }
        return next?.hasMoreChildrenThan(k: k, currentCount: currentCount + 1) ?? false
    }

    func hasMoreChildrenThan(k: UInt) -> Bool {
        return hasMoreChildrenThan(k: k, currentCount: 1)
    }
}

class Solution {

    // Given k- Grouping, this appears like we want the ability to reverse subgroupings

    // Practice with a basic reverse (iterative)
    func reverse(node: ListNode?) -> ListNode? {

        var currentNode: ListNode? = node
        var nextNode: ListNode?
        var previousNode: ListNode?

        while currentNode != nil {
            nextNode = currentNode?.next;
            currentNode?.next = previousNode;
            previousNode = currentNode;
            currentNode = nextNode;
        }

        return previousNode
    }

    func reverse(node: ListNode?, maxCount: UInt) -> (list: ListNode?, remainder: ListNode?) {

        var currentNode: ListNode? = node
        var nextNode: ListNode?
        var previousNode: ListNode?
        var index = 0

        while currentNode != nil && index < maxCount {
            nextNode = currentNode?.next;
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = nextNode
            index += 1
        }

        return (list: previousNode, remainder: nextNode)
    }

    // Currently O(n^2) due to inspection of children count
    // Would have
    // Could do this cheaper via recursion, but I'm running into Memory Issues
    // When updating next to a recursively returned value
    func reverseKGroup(_ head: ListNode?, _ k: UInt) -> ListNode? {

        // Reverse Groups of the list (Store in Array of tuples)
        var groups: [(list: ListNode?, remainder: ListNode?)] = []
        var node = head
        var finished = false

        // Iterate Through List
        while !finished {

            // Opt out of reversing if Children if Cound < K
            if let node = node,
                !node.hasMoreChildrenThan(k: k) {
                groups.append((list: node, remainder: nil))
                finished = true
            }
            else {
                // Reverse
                let group = reverse(node: node, maxCount: k)
                groups.append(group)
                node = group.remainder
                finished = group.remainder == nil
            }
        }

        // Link Groups back together:
        var newHead: ListNode?
        for tuple in groups.reversed() {
            tuple.list?.append(node: newHead)
            newHead = tuple.list
        }
        return newHead
    }
}

// Test Mocks
extension ListNode {
    static func input() -> ListNode? {
        return ListNode(values: [1,2,3,4,5])
    }
    static func inputv2() -> ListNode? {
        return ListNode(values: [1,2,3,4,5,6])
    }
    static func inputv3() -> ListNode? {
        return ListNode(values: [1,2])
    }

    static func outputK2() -> ListNode? {
        return ListNode(values: [2,1,4,3,5])
    }

    static func outputK3() -> ListNode? {
        return ListNode(values:[3,2,1,4,5])
    }

    static func outputv2K3() -> ListNode? {
        return ListNode(values:[3,2,1,6,5,4])
    }
    static func outputv3K3() -> ListNode? {
        return ListNode(values:[1,2])
    }
}

// Tests - Even Reversing
Solution().reverseKGroup(ListNode.input(), 2)
Solution().reverseKGroup(ListNode.input(), 2)?.description == ListNode.outputK2()?.description

//
Solution().reverseKGroup(ListNode.inputv2(), 3)
Solution().reverseKGroup(ListNode.inputv2(), 3)?.description == ListNode.outputv2K3()?.description


// Tests - If the number of nodes is not a multiple of k then left-out nodes in the end should remain as it is.
// > K Value
Solution().reverseKGroup(ListNode.input(), 3)?.description == ListNode.outputK3()?.description
// < K Value
Solution().reverseKGroup(ListNode.inputv3(), 3)?.description == ListNode.outputv3K3()?.description

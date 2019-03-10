import Foundation

/*
 143. Reorder List
 Medium

 Given a singly linked list L: L0→L1→…→Ln-1→Ln,
 reorder it to: L0→Ln→L1→Ln-1→L2→Ln-2→…

 You may not modify the values in the list's nodes, only nodes itself may be changed.

 Example 1:

 Given 1->2->3->4, reorder it to 1->4->2->3.
 Example 2:

 Given 1->2->3->4->5, reorder it to 1->5->2->4->3.
 */

class ListNode {
    var value: Int
    var next: ListNode?

    init(_ value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }

    // Init List from literal Array
    convenience init?(values: [Int]) {
        guard let value = values.first else { return nil }
        let next = ListNode(values: Array(values.suffix(from: 1)))
        self.init(value, next: next)
    }
}

// MARK: - CustomStringConvertible
extension ListNode: CustomStringConvertible {
    var description: String {
        return "\(value) -> \(next?.description ?? "nil")"
    }
}

// MARK: - Remove/Insert Support
extension ListNode {

    /// Removes tail node from list
    ///
    /// - Parameters:
    ///     - head: Head of a linked list
    /// - Performance: O(n)
    /// - Returns: ListNode which was removed from list
    func removeTail() -> ListNode? {

        var iterator: ListNode? = self
        while iterator?.next?.next != nil {
            iterator = iterator?.next
        }

        let tail = iterator?.next
        iterator?.next = nil
        return tail
    }

    /// Insert Node at index
    ///
    /// - Parameters:
    ///     - node: Node to insert
    /// - Performance: O(index)
    ///     - index: Offset Index for placement
    func insert(node: ListNode, at index: Int) {
        var indexOffset = 0
        var iterator: ListNode? = self

        // Seek out position just before insertion index
        while indexOffset < index - 1 {
            indexOffset += 1
            iterator = iterator?.next
        }

        // Update Pointers
        let temp = iterator?.next
        iterator?.next = node
        node.next = temp
    }

    var allValues: [Int] {
        var values = [Int]()

        values.append(value)

        var iterator = self.next
        while iterator != nil {
            if let node = iterator {
                values.append(node.value)
            }
            iterator = iterator?.next
        }
        return values
    }
}

// MARK: - Count / Splitting Support
extension ListNode {
    var count: Int {
        return (next?.count ?? 0) + 1
    }

    // Split Second Half of Lst to a separate List
    func bisect() -> ListNode? {
        let expectedIndex = (count / 2)
        var temp: ListNode? = self
        var counter = 0

        var rhs: ListNode?
        while temp != nil,
            counter <= expectedIndex {

                // Find Bisecting location
                if counter == expectedIndex {
                    rhs = temp?.next
                    temp?.next = nil
                    break
                } else {
                    temp = temp?.next
                    counter += 1
                }
        }

       return rhs
    }

    /// Appends new node at the tail of the list
    func append(_ node: ListNode) {
        var tail: ListNode? = self

        // Find Tail
        while tail?.next != nil {
            tail = tail?.next
        }

        tail?.next = node
    }
}

// Reversable Support
extension ListNode {
    func reversed() -> ListNode? {

        var currentNode: ListNode? = self
        var nextNode: ListNode?
        var previousNode: ListNode?

        while currentNode != nil {
            nextNode = currentNode?.next
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = nextNode
        }

        return previousNode
    }
}

class Solution {
    /// Reorders list to place tail sample tail node between each node
    ///
    /// By searching for tail each time, this yields O(n^2) performance
    /// which is problematic. In order to prevent this O(n) lookup, perhaps we can
    /// prefetch the count/list a single time up front
    ///
    /// - Parameters:
    ///     - head: Head of a linked list
    /// - Returns: Void
    func reorderListSlow(_ head: ListNode?) {
        guard let node = head else { return }
        var count = node.count

        // Iterator
        var iterator: ListNode? = node

        // While there are > 2 remaining nodes, continue
        while count > 2 {
            let tail = iterator?.removeTail()

            let temp = iterator?.next
            iterator?.next = tail
            tail?.next = temp

            // Update for next cycle
            iterator = temp
            count -= 2
        }
    }

    /// Reorders list to place tail sample tail node between each node
    ///
    /// - Note:
    ///     We learned in the previous approach, looking up tail each time yields poor performance results.
    ///     Rather than do this for each insertion, pre-determine list of tail items to insert, reverse, then apply
    ///     by popping off the head
    ///
    ///     Extract known list items ahead of time, reverse it, then iterate popping off substitutions
    ///
    /// - Parameters:
    ///     - head: Head of a linked list
    /// - Returns: Void
    func reorderList(_ head: ListNode?) {

        guard let node = head else { return }

        guard let tailSubstitutions = node
            .bisect()?
            .reversed() else { return }

        var iterator: ListNode? = node
        var tailSubstitutionsIterator: ListNode? = tailSubstitutions

        while iterator != nil,
            tailSubstitutionsIterator != nil {

                // Re-Ordering References
                let temp = iterator?.next
                iterator?.next = nil

                let tempTail = tailSubstitutionsIterator
                tailSubstitutionsIterator = tailSubstitutionsIterator?.next
                tempTail?.next = nil

                tempTail?.next = temp
                iterator?.next = tempTail

                iterator = temp
        }
    }
}

let list1 = ListNode(values: [1, 2, 3, 4])
let list2 = ListNode(values: [1, 2, 3, 4, 5])
let list3 = ListNode(values: [1, 2, 3, 4, 5,6,7,8,9])

Solution().reorderList(list1)
list1?.allValues
list1?.allValues == [1,4,2,3]

Solution().reorderList(list2)
list2?.allValues
list2?.allValues == [1,5,2,4,3]
list2

Solution().reorderList(list3)
list3?.allValues == [1,9,2,8,3,7,4,6,5]
list3

//list1?.bisect()
//list2?.bisect()
//list3?.bisect()

//Solution().reorderList(list3)

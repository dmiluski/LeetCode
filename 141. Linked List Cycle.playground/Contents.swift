import Foundation

/*
 141. Linked List Cycle
 Easy
 
 Given a linked list, determine if it has a cycle in it.

 To represent a cycle in the given linked list, we use an integer pos which represents the position (0-indexed) in the linked list where tail connects to. If pos is -1, then there is no cycle in the linked list.



 Example 1:

 Input: head = [3,2,0,-4], pos = 1
 Output: true
 Explanation: There is a cycle in the linked list, where tail connects to the second node.


 Example 2:

 Input: head = [1,2], pos = 0
 Output: true
 Explanation: There is a cycle in the linked list, where tail connects to the first node.


 Example 3:

 Input: head = [1], pos = -1
 Output: false
 Explanation: There is no cycle in the linked list.

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

// MARK: - Output to Array
extension ListNode {
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

class Solution {

    /// Removes duplicates from linked list
    ///
    /// Uses Recursion to delete elements of an array back to front
    ///
    /// - Parameters:
    ///     - head: Head of ListNode
    ///     - duplicateModel: Preconfigured Dictionary Lookup of value counts to identify duplicates
    ///
    /// - Note:
    ///     Leveraged inout for faster reference model rather than copying
    private func recurseDeleteDuplicate(head: ListNode?,
                                        duplicateModel: inout [Int: Int]) -> ListNode? {

        // Sentinel Check- End of List
        guard let head = head,
            let count = duplicateModel[head.value] else { return nil }


        switch count {
        case 1:
            head.next = recurseDeleteDuplicate(head: head.next, duplicateModel: &duplicateModel)
            return head
        default:
            return recurseDeleteDuplicate(head: head.next, duplicateModel: &duplicateModel)
        }
    }

    /// Removes duplicates from linked list
    ///
    /// - Performance: O(n)
    /// - Space Complexity: O(n) Lookup
    ///
    /// - Parameters:
    ///     - head: Head of ListNode
    ///
    /// - Note:
    ///     First seek out duplicates by filling Dict Lookup of Count
    ///     If count > 1, skip to next node
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {

        var node = head

        // HashTable of each value's count
        var duplicateModel = [Int: Int]()

        // Fill Model
        while node != nil {
            guard let temp = node else { break }
            duplicateModel[temp.value] = (duplicateModel[temp.value] ?? 0) + 1
            node = node?.next
        }

        // Reset Node to Head, then iterate through list again
        node = head

        return recurseDeleteDuplicate(head: node, duplicateModel: &duplicateModel)
    }
}


// Section to reverse
let input1 = ListNode(values: [1, 2, 3, 3, 4, 4, 5])
Solution().deleteDuplicates(input1)?.allValues// == [1, 2, 5]

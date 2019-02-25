import Foundation

/*
 92. Reverse Linked List II

 Reverse a linked list from position m to n. Do it in one-pass.

 Note: 1 ≤ m ≤ n ≤ length of list.

 Example:

 Input: 1->2->3->4->5->NULL, m = 2, n = 4
 Output: 1->4->3->2->5->NULL
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

extension ListNode: CustomStringConvertible {
    var description: String {
        return "\(value) -> \(next?.description ?? "nil")"
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

    /// Reverses Subset of List dictated by range
    /// - parameters:
    ///     - head: List Head
    ///     - m: start location
    ///     - n: end location
    func reverseBetween(_ head: ListNode?,
                        _ m: Int,
                        _ n: Int) -> ListNode? {

        // QuickCheck for empty
        // m is non-negative
        // n is greater than 1 (Otherwise nothing to reverse with
        guard head != nil,
            m >= 0,
            n > m else { return head }

        // Goals:
        //  - Identify Location, save mNode, saveMNode.next
        //  - Begin reversion until meet length
        //  - save endRange.next
        //  - mNode.next = endOfRangeNode

        // Basic reveral model
        var currentNode: ListNode? = head
        var previousNode: ListNode?

        // Range Model References
        var currentLocation = 1
        var nodeBeforeLocation: ListNode?
        var nodeAtLocation: ListNode?
        var shouldExitEarly = false

        // Iterate

        while currentNode != nil, !shouldExitEarly {
            // Only Reverse Nodes in Range(location: m, length: n)
            switch currentLocation {
            case ..<m:
                // Iterate
                previousNode = currentNode
                currentNode = currentNode?.next
            case m:
                // Found Location, stash previous
                nodeBeforeLocation = previousNode
                nodeAtLocation = currentNode

                // Iterate, don't reverse yet
                previousNode = currentNode

                let tempNext = currentNode?.next

                // Nil next until end of section found
                currentNode?.next = nil
                currentNode = tempNext
            case m..<n:
                // Given we're in the range, reverse
                let nextNode = currentNode?.next
                currentNode?.next = previousNode
                previousNode = currentNode
                currentNode = nextNode

            case n:
                // Given we've reached the end of the range Adjust pointers, exit as rest of relations or in tact
                let nextNode = currentNode?.next
                currentNode?.next = previousNode
                nodeBeforeLocation?.next = currentNode
                nodeAtLocation?.next = nextNode

                previousNode = currentNode
                currentNode = nodeAtLocation

                // Signal Early Loop Exit so we don't iterate nodes that don't require reversing
                shouldExitEarly = true
            default:
                currentNode = currentNode?.next

            }
            currentLocation += 1

        }

        // Special Case Check
        // If reverse range starts at 1 (initial position), that actual start is stored in previousNode
        if m == 1 {
            return previousNode
        } else {
            return head
        }

    }
}


// Section to reverse
let nodes2 = ListNode(values: [1,2,3,4,5,6,7,8])
let output = Solution().reverseBetween(nodes2, 2, 3)
//
let nodes3 = ListNode(values:[1,2,3,4,5])
let output2 = Solution().reverseBetween(nodes3, 2, 4)

let nodes4 = ListNode(values:[3,5])
let output3 = Solution().reverseBetween(nodes4, 1, 2)

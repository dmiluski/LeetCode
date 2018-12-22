//: Playground - noun: a place where people can play

import Foundation

/*
 2. Add Two Numbers

 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Example

 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */

/**
 * Definition for singly-linked list.
 */
public class ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val &&
            lhs.next == rhs.next
    }

    public var val: Int
    public var next: ListNode?
    public init(_ val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }


    var fullListValue: Int {
        return fullListValue(node: self, position: 0, sum: 0)
    }

    // Recursive Helper
    private func fullListValue(node: ListNode?, position: Int, sum: Int) -> Int {
        guard let node = node else { return sum }
        let newSum =  (node.val * pow(10, position)) + sum
        return fullListValue(node: node.next, position: position + 1, sum: newSum)
    }
}


func pow(_ value : Int, _ exponent : Int) -> Int {
    return Int(pow(Double(value), Double(exponent)))
}



// Approach:
//  Extract Values, Sum, then Create new ListNodes
class Solution1 {
    func addTwoNumbers(_ l1: ListNode, _ l2: ListNode) -> ListNode? {

        // Extrapolate Int from each list and sum
        var sum = l1.fullListValue + l2.fullListValue

        // Construct Array of Individual Int Values
        var individualIntValues: [Int] = []
        while sum > 1 {
            let remainder = sum % 10
            sum = sum / 10
            individualIntValues.append(remainder)
        }

        var rootNode: ListNode?
        for item in individualIntValues.reversed(){
            let node = ListNode(item)
            node.next = rootNode
            rootNode = node
        }

        return rootNode
    }
}

// Approach:
//  Given List is reverse ordered, we can just add pairs of node values and carry the extra
//  This reduces the O(n) extraction time as well as exponent calculation times
class Solution2 {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return addTwoNumbers(l1, l2, carry: 0)
    }

    private func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?, carry: Int) -> ListNode? {

        // Sentinal Check
        guard l1 != nil || l2 != nil || carry > 0 else { return nil }

        // Determine Current Node Value, Carry
        let sum = (l1?.val ?? 0) + (l2?.val ?? 0) + carry
        let newCary = sum / 10
        let val = sum % 10

        // Build node with recursive next value
        return ListNode(val, next: addTwoNumbers(l1?.next, l2?.next, carry: newCary))
    }
}



// Test
let firstInt = ListNode(2, next: ListNode(4, next: ListNode(3)))
firstInt.fullListValue

let secondInt = ListNode(5, next: ListNode(6, next: ListNode(4)))
secondInt.fullListValue

let expectedOutput = ListNode(7, next: ListNode(0, next: ListNode(8)))
expectedOutput.fullListValue

Solution1().addTwoNumbers(firstInt, secondInt) == expectedOutput
Solution2().addTwoNumbers(firstInt, secondInt) == expectedOutput

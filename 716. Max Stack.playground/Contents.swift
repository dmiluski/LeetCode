import Foundation
/*
 716. Max Stack

 Design a max stack that supports push, pop, top, peekMax and popMax.
 
    1. push(x) -- Push element x onto stack.
    2. pop() -- Remove the element on top of the stack and return it.
    3. top() -- Get the element on the top.
    4. peekMax() -- Retrieve the maximum element in the stack.
    5. popMax() -- Retrieve the maximum element in the stack, and remove it. If you find more than one maximum elements, only remove the top-most one.
 
 Example 1:
 
    MaxStack stack = new MaxStack();
    stack.push(5);
    stack.push(1);
    stack.push(5);
    stack.top(); -> 5
    stack.popMax(); -> 5
    stack.top(); -> 1
    stack.peekMax(); -> 5
    stack.pop(); -> 1
    stack.top(); -> 5
 
 Note:
 
    -1e7 <= x <= 1e7
    Number of operations won't exceed 10000.
    The last four operations won't be called when stack is empty.
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

class MaxStack {
    private(set) var root: ListNode? = nil
    
    /** initialize your data structure here. */
    init() {
        
    }
    
    func push(_ x: Int) {
        let node = ListNode(x)
        node.next = root
        root = node
    }
    
    func pop() -> Int {
        let value = root?.value
        root = root?.next
        return value ?? 0
    }
    
    func top() -> Int {
        return root?.value ?? 0
    }
    
    // O(n)
    func peekMax() -> Int {
        var node = root
        var maxValue = node?.value ?? 0
        
        while let step = node {
            maxValue = max(maxValue, step.value)
            node = node?.next
        }
        return maxValue
    }
    
    // O(n)
    func popMax() -> Int {
        
        // Lookup Max O(n)
        let maxValue = peekMax()
        
        // Remove item
        var previous: ListNode?
        var node = root
        
        // Find Value
        var stop = false
        while let step = node, !stop {
            if step.value == maxValue {
                if let previous = previous {
                    previous.next = step.next
                    step.next = nil
                } else {
                    root = step.next
                }
                stop = true
            }
            
            previous = node
            node = node?.next
        }
        return maxValue
    }
}

/**
 * Your MaxStack object will be instantiated and called as such:
 * let obj = MaxStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.peekMax()
 * let ret_5: Int = obj.popMax()
 */

let stack = MaxStack()
stack.push(5)
stack.push(1)
stack.push(5)
stack.top() == 5// -> 5
stack.popMax() == 5

stack.top() == 1
stack.peekMax() == 5
stack.pop() == 1
stack.top() == 5



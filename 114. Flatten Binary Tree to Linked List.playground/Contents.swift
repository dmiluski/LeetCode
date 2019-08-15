import Foundation

/*
 114. Flatten Binary Tree to Linked List
 Medium

 Given a binary tree, flatten it to a linked list in-place.

 For example, given the following tree:

 1
 / \
 2   5
 / \   \
 3   4   6
 The flattened tree should look like:

 1
 \
 2
 \
 3
 \
 4
 \
 5
 \
 6
 */

// Binary Tree Node
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?

    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

extension TreeNode {
    var rightMostNode: TreeNode? {

        var node: TreeNode? = self
        while node != nil {
            guard node?.right != nil else { break }
            node = node?.right
        }
        return node
    }
}

extension TreeNode {
    func printInOrder() {
        left?.printInOrder()
        print(val)
        right?.printInOrder()
    }

    func printDownRight() {
        print(val)
        right?.printDownRight()
    }
}



class Solution {

    /// Given Binary Tree, Convert to linked list on rightNodes
    ///
    /// - Parameters:
    ///     - root: Minimum Value Root
    ///
    /// - Returns: Rightmost TreeNode if available
    private func flattenAndReturnRightmostNode(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }

        let newTail = flattenAndReturnRightmostNode(root.right)
        let next = root.right
        let leftTail = flattenAndReturnRightmostNode(root.left)

        root.right = root.left
        leftTail?.right = next
        root.left = nil

        return newTail
    }

    /// Given Binary Tree, Convert to linked list on rightNodes
    ///
    /// - Parameters:
    ///     - root: Minimum Value Root
    func flatten(_ root: TreeNode?) {
        flattenAndReturnRightmostNode(root)
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)

root.printDownRight()
print()
Solution().flatten(root)
root.printDownRight()



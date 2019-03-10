import Foundation
/*
 125. Valid Palindrome

 Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

 Note: For the purpose of this problem, we define empty string as valid palindrome.

 Example 1:

 Input: "A man, a plan, a canal: Panama"
 Output: true
 Example 2:

 Input: "race a car"
 Output: false
 */


extension String {
    var isPalindrome: Bool {
        return self == String(self.reversed())
    }

    /// Sanitizes the input to adhere to the given character Set
    ///
    /// - Parameter characterSet: A set of characters to remove
    /// - Returns: The sanitized String
    public func removingCharacters(in characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }
}

class Solution {
    func isPalindrome(_ s: String) -> Bool {

        // Business Rule: Empty is considered true
        guard !s.isEmpty else { return true }

        let normalizedInput = s
            .removingCharacters(in: CharacterSet.alphanumerics.inverted)
            .lowercased()

        return normalizedInput.isPalindrome
    }
}

Solution().isPalindrome("A man, a plan, a canal: Panama")
Solution().isPalindrome("race a car")

"dad".isPalindrome
"a 3 #".trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

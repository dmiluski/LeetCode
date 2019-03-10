import Foundation
/*
 929. Unique Email Addresses
 Easy

 Every email consists of a local name and a domain name, separated by the @ sign.

 For example, in alice@leetcode.com, alice is the local name, and leetcode.com is the domain name.

 Besides lowercase letters, these emails may contain '.'s or '+'s.

 If you add periods ('.') between some characters in the local name part of an email address, mail sent there will be forwarded to the same address without dots in the local name.  For example, "alice.z@leetcode.com" and "alicez@leetcode.com" forward to the same email address.  (Note that this rule does not apply for domain names.)

 If you add a plus ('+') in the local name, everything after the first plus sign will be ignored. This allows certain emails to be filtered, for example m.y+name@email.com will be forwarded to my@email.com.  (Again, this rule does not apply for domain names.)

 It is possible to use both of these rules at the same time.

 Given a list of emails, we send one email to each address in the list.  How many different addresses actually receive mails?



 Example 1:

 Input: ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]
 Output: 2
 Explanation: "testemail@leetcode.com" and "testemail@lee.tcode.com" actually receive mails


 Note:

 1 <= emails[i].length <= 100
 1 <= emails.length <= 100
 Each emails[i] contains exactly one '@' character.

 */

extension String {

    /// Removes all instances of characterSet from String
    ///
    /// - Parameters:
    ///     - characterSet: CharacterSet containing characters not wanted
    ///
    /// - Returns: String with characterSet items removed
    func removing(_ characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }
}
class Solution {

    /// Identify number of unique emails
    ///
    /// - Parameters:
    ///     - emails: Array of emails consisting of a local name and a comain name separated by @
    ///
    /// - Note:
    ///      If you add periods ('.') between some characters in the local name part of an email address, mail sent
    ///     there will be forwarded to the same address without dots in the local name.  For example,
    ///     "alice.z@leetcode.com" and "alicez@leetcode.com" forward to the same email address.
    ///     (Note that this rule does not apply for domain names.)
    func numUniqueEmails(_ emails: [String]) -> Int {

        var uniquingSet = Set<String>()
        let periodCharacterSet = CharacterSet(charactersIn: ".")

        for email in emails {

            // Split name from domain
            let nameAndDomain = email.split(separator: "@")
            guard email.split(separator: "@").count == 2 else { continue }

            var name = String(nameAndDomain[0])
            let domain = String(nameAndDomain[1])

            // Remove Content after first '+'
            name = String(name.split(separator: "+").first ?? "")

            guard !name.isEmpty else { continue }

            // Normalize name (forwarding) and recombine with domain
            name = name.removing(periodCharacterSet)

            let normalizedName = [name, "@", domain].joined()
            uniquingSet.insert(normalizedName)
        }

        return uniquingSet.count
    }
}

// Tests
let input = ["test.email+alex@leetcode.com",
             "test.e.mail+bob.cathy@leetcode.com",
             "testemail+david@lee.tcode.com"]


"test.email+alex".removing(CharacterSet.alphanumerics.inverted)

Solution().numUniqueEmails(input) == 2



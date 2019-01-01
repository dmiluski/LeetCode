import Foundation
import Accelerate
/*
 121. Best Time to Buy and Sell Stock

 Say you have an array for which the ith element is the price of a given stock on day i.
 
 If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.
 
 Note that you cannot sell a stock before you buy one.
 
 Example 1:
 
    Input: [7,1,5,3,6,4]
    Output: 5
 
    Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
    Not 7-1 = 6, as selling price needs to be larger than buying price.

 Example 2:
 
    Input: [7,6,4,3,1]
    Output: 0
 
    Explanation: In this case, no transaction is done, i.e. max profit = 0.
 */

/*
 Approach:
    Profit == Final - Initial
 
 
 */
class Solution {
    // Approach: Compare each prior to minimum to identify  the max profit
    //
    // RunTime: O(n^2)
    // Why:
    //  Use final as sell time, then move in finding lowest item in the remainder of the set
    func maxProfitNSquared(_ prices: [Int]) -> Int {
        var profit = 0
        
        for (index, price) in prices.reversed().enumerated() {
            if let minimum = prices[0..<(prices.count - 1 - index)].min() {
                profit = max(price - minimum, profit)
            }
        }
        return profit
    }
    
    // Because profit only requires comparing to previous minimum, we can keep a minimum value and calculate the profit
    //
    // Runtime: O(n)
    // Space: O(1)
    func maxProfit(_ prices: [Int]) -> Int {
        var runningMinimum = Int.max
        var profit = 0

        prices.forEach { (price) in
            runningMinimum = min(runningMinimum, price)
            profit = max(price - runningMinimum, profit)
        }
        return profit
    }
}

// Tests
Solution().maxProfitNSquared([7,1,5,3,6,4]) == 5
Solution().maxProfitNSquared([7,6,4,3,1]) == 0

Solution().maxProfit([7,1,5,3,6,4]) == 5
Solution().maxProfit([7,6,4,3,1]) == 0

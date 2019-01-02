import Foundation
/*
 200. Number of Islands

 Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
 
 Example 1:
 
    Input:
    11110
    11010
    11000
    00000
 
    Output: 1
 
 Example 2:
 
    Input:
    11000
    11000
    00100
    00011
 
    Output: 3
 */



/*
 Approach:
    Create a model to identify water/land
    Parse Model to identify islands
 
 How:
    For each cell, check it's surroundings?
    If an edge, mark it? If no where else to go, mark an island?
 
    Mark visited?
 
 Considerations:
    If Land, check up/down/left/right (Marking visited)
    If we navigate like this, with backtracking, this could balloon in terms of complexity?
 */

struct Position: Equatable, Hashable {
    let row: Int
    let column: Int
}

enum Feature {
    case water, land
    
    init(_ character: Character) {
        switch character {
        case "1": self = .land
        case "0": self = .water
        default: fatalError("Unsupported Natural Option")
        }
    }
}

class Cell {
    let feature: Feature
    var hasVisited: Bool = false
    
    init(feature: Feature) {
        self.feature = feature
    }
}

class Model {
    var cells: [[Cell]]
    
    init(_ grid: [[Character]]) {
        var rows = [[Cell]]()
        rows.reserveCapacity(grid.count)
        
        for item in grid {
            var row: [Cell] = []
            row.reserveCapacity(item.count)
            
            for value in item {
                row.append(Cell(feature: Feature(value)))
            }
            rows.append(row)
        }
        self.cells = rows
    }
    
    func cell(for position: Position) -> Cell {
        return cells[position.row][position.column]
    }
    
    // Crawl Full island marking visited
    func crawlIsland(_ position: Position) {
        
        // Crawl relative unvisited island positions
        let surroundingUnvisitedLandCells = validPositionsSurrounding(position)
            .map({ ($0, cell(for: $0)) })
            .filter({$0.1.feature == .land && !$0.1.hasVisited})
        
        
        surroundingUnvisitedLandCells.forEach { (surroundingPosition, cell) in
            cell.hasVisited = true

            // Crawl additional land
            if cell.feature == .land {
                crawlIsland(surroundingPosition)
            }
        }
    }
    
    // For iterating over the set of Cells
    func index(after position: Position) -> Position? {
        // First Attempt to visit Right?
        if let index = cells[position.row].index(position.column, offsetBy: 1, limitedBy: cells[position.row].count - 1) {
            return Position(row: position.row, column: index)
        }
        // Then Attempt next row
        else if let index = cells.index(position.row, offsetBy: 1, limitedBy: cells.count - 1) {
            return Position(row: index, column: 0)
        }
        return nil
    }
    
    // For nearby comparisons
    // Returns an array of viable Positions surrounding (left, right, up, down)
    func validPositionsSurrounding(_ position: Position) -> Set<Position> {
        var positions = Set<Position>()
        
        // Left?
        if let index = cells[position.row].index(position.column, offsetBy: -1, limitedBy: 0) {
            positions.insert(Position(row: position.row, column: index))
        }
        
        // Right?
        if let index = cells[position.row].index(position.column, offsetBy: 1, limitedBy: cells[position.row].count - 1) {
            positions.insert(Position(row: position.row, column: index))
        }
        
        // Up?
        if let index = cells.index(position.row, offsetBy: -1, limitedBy: 0) {
            positions.insert(Position(row: index, column: position.column))
        }
        
        // Down?
        if let index = cells.index(position.row, offsetBy: 1, limitedBy: cells.count - 1) {
            positions.insert(Position(row: index, column: position.column))
        }

        return positions
    }
    
    
    
}

class Solution {
    
    // Iterate through all items:
    // If Island && Surrounding items haven't been visited, bump island count by one
    // Iterate over each cell, inspect 4 surrounding items.
    // If land, and if surrounding item has not been visited, mark as a new island
    //
    // Performance: O(4*n)
    func numIslands(_ grid: [[Character]]) -> Int {
        guard !grid.isEmpty else { return 0 }

        let model = Model(grid)
        var numberOfIslands = 0
        
        
        // Start at top left
        var position: Position? = Position(row: 0, column: 0)
        
        while let localPosition = position {
            let cell = model.cell(for: localPosition)
            
            if !cell.hasVisited {
                switch cell.feature {
                case .land:
                    numberOfIslands += 1
                    model.crawlIsland(localPosition)
                case .water:
                    // No-op
                    break
                }
            }
            cell.hasVisited = true
            
            position = model.index(after: localPosition)
        }
        
        return numberOfIslands
    }
}

let inputV1: [[Character]] = [
    ["1","1","1","1","0"],
    ["1","1","0","1","0"],
    ["1","1","0","0","0"],
    ["0","0","0","0","0"]
]

let inputv2: [[Character]] = [
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
]

let inputv3: [[Character]] = [
    ["1","1","1"],
    ["0","1","0"],
    ["1","1","1"]
]

let inputv4: [[Character]] = [
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]]

// Tests
Solution().numIslands(inputV1) == 1
Solution().numIslands(inputv2) == 3
Solution().numIslands(inputv3) == 1
Solution().numIslands(inputv4) == 3

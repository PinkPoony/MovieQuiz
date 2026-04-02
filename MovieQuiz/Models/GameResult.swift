import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThen(_another: GameResult) -> Bool {
        correct > _another.correct
    }

}

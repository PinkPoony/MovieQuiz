import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard
    private enum Keys: String {
        case gamesCount
        case bestGameCorrect
        case bestGameTotal
        case bestGameDate
        case totalCorrectAnswers
        case totalQuestionsAsked
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.bestGameCorrect.rawValue)
            let total = storage.integer(forKey: Keys.bestGameTotal.rawValue)
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.bestGameCorrect.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGameTotal.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    var totalAccurency: Double {
        let allAnswersCount = storage.integer(forKey: Keys.totalCorrectAnswers.rawValue)
        let allQuestions = storage.integer(forKey: Keys.totalQuestionsAsked.rawValue)
        return allAnswersCount == 0 ? 0: Double(allAnswersCount) / Double(allQuestions) * 100
    }
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        
        let totalCorrect = storage.integer(forKey: Keys.totalCorrectAnswers.rawValue)
        let totalQuestions = storage.integer(forKey: Keys.totalQuestionsAsked.rawValue)
    
        storage.set(totalCorrect + count, forKey: Keys.totalCorrectAnswers.rawValue)
        storage.set(totalQuestions + amount, forKey: Keys.totalQuestionsAsked.rawValue) 
        
        let currentGame = GameResult(correct: count, total: amount, date: Date())
        if currentGame.correct > bestGame.correct {
            bestGame = currentGame
        }
        
    }
    
}

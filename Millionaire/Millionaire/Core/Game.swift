//
//  Game.swift
//  Millionaire
//
//  Created by Shisetsu on 31.08.2021.
//

import Foundation

final class Game {
    
    static let shared = Game()
    
    var session: Session?
    
    private let caretaker = SaveLoad()
 
    var score = [ScoreTable]() {
        didSet {
            caretaker.saveData(toSave: self.score)
        }
    }
    
    private init() {
        self.score = self.caretaker.loadData()
    }
    
    func recordScore(_ score: ScoreTable) {
        self.score.append(score)
    }
    
    func didEndGame() {
        guard let gameSession = self.session else { return }
        let answersCount = gameSession.correctAnswers
        let reward = gameSession.totalReward
        let score = ScoreTable(score: Int(answersCount), date: Date(), reward: reward)
        self.recordScore(score)
        self.session = nil
    }
    
}

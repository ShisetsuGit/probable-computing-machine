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
    
    private let caretaker = Save_Load()
 
    var score = [ScoreTable]() {
        didSet {
            caretaker.saveData(toSave: score)
        }
    }
    
    private init() {
        self.score = self.caretaker.loadData()
    }
    
    func recordScore(_ score: ScoreTable) {
        self.score.append(score)
    }
    
}

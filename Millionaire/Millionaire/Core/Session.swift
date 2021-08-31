//
//  Session.swift
//  Millionaire
//
//  Created by Shisetsu on 31.08.2021.
//

import Foundation

final class Session {
    
    var questionCount: Int
    var correctAnswers: Int
    var totalReward: Int
    
    init(questionCount: Int, correctAnswers: Int, totalReward: Int) {
        self.questionCount = questionCount
        self.correctAnswers = correctAnswers
        self.totalReward = totalReward
    }
}

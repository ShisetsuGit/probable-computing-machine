//
//  GameScene.swift
//  Millionaire
//
//  Created by Shisetsu on 25.08.2021.
//

import UIKit

protocol GameSceneDelegate: AnyObject {
    func didEndGame(session: Session?)
}

final class GameScene: UIViewController {
    
    weak var gameDelegate: GameSceneDelegate?
    var session: Session?

    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var PlayerName: UILabel!
    @IBOutlet weak var QuestionNumber: UILabel!
    @IBOutlet weak var AnswerA: AnswerButton!
    @IBOutlet weak var AnswerB: AnswerButton!
    @IBOutlet weak var AnswerC: AnswerButton!
    @IBOutlet weak var AnswerD: AnswerButton!
    
    var question: QuestionsPull?
    var questionNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = Session(questionCount: questions.count, correctAnswers: 0, totalReward: 0)
        setupGameData()
    }
    
    @IBAction func choseAnswer(_ sender: UIButton) {
        let info = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        if sender.tag == question?.correctAnswer {
            info.title = "И это был... Правильный ответ!"
            session?.correctAnswers += 1
            questionNumber += 1
            session?.totalReward += question!.answerReward
            
            if questionNumber < questions.count {
                info.addAction(UIAlertAction(title: "Продолжаем", style: .default, handler: setupGameData))
                present(info, animated: true)
            } else {
                info.title = "Игра закончена"
                info.addAction(UIAlertAction(title: "На главный экран", style: .default) {
                    [weak self] _ in
                    self?.dismiss(animated: true)
                    self?.gameDelegate?.didEndGame(session: self?.session)
                })
                present(info, animated: true)
            }
        } else {
            info.title = "И это был... Неправильный ответ!"
            info.addAction(UIAlertAction(title: "Игра окончена", style: .default) {
                [weak self] _ in
                self?.dismiss(animated: true)
                self?.gameDelegate?.didEndGame(session: self?.session)
            })
            present(info, animated: true)
        }
    }
    
 
    func setupGameData(action: UIAlertAction! = nil) {
        question = questions[questionNumber]
        question?.answers.shuffle()
        
        Question.text = question?.question
        
        PlayerName.text = "У нас в студии Игрок 1"
        
        QuestionNumber.text = "Вопрос № \(questionNumber + 1) из 6 "
        
        AnswerA.setTitle(question?.answers[0].answer, for: .normal)
        AnswerA.tag = (question?.answers[0].id)!
        AnswerB.setTitle(question?.answers[1].answer, for: .normal)
        AnswerB.tag = (question?.answers[1].id)!
        AnswerC.setTitle(question?.answers[2].answer, for: .normal)
        AnswerC.tag = (question?.answers[2].id)!
        AnswerD.setTitle(question?.answers[3].answer, for: .normal)
        AnswerD.tag = (question?.answers[3].id)!
    }
}

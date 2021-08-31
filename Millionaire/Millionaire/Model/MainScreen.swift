//
//  MainScreen.swift
//  Millionaire
//
//  Created by Shisetsu on 24.08.2021.
//

import UIKit

final class MainScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let gameVC = storyBoard.instantiateViewController(withIdentifier: "GameScreen") as? GameScene {
            gameVC.gameDelegate = self
            Game.shared.session = gameVC.session
            gameVC.modalPresentationStyle = .fullScreen
            self.present(gameVC, animated: false, completion:nil)
        }
    }
    
    @IBAction func showScores(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ScoreScreen") as? ScoreTableScene {
            nextViewController.modalPresentationStyle = .popover
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
}

extension MainScreen: GameSceneDelegate {
    func didEndGame(session: Session?) {
        Game.shared.session = session
        if let answersCount = Game.shared.session?.correctAnswers,
           let reward = Game.shared.session?.totalReward {
            let score = ScoreTable(score: Int(answersCount), date: Date(), reward: reward)
            Game.shared.recordScore(score)
        }
    }
}

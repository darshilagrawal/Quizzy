

import UIKit
import SPConfetti

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var barProgress: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    var lastChecker: Bool = false
    var timer=Timer()
    var quizBrain=QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer=sender.currentTitle!
        let userGotItRight=quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            print("RIGHT")
            UIView.transition(with: sender,
                              duration: 0.5,
                              options: .allowUserInteraction,
                              animations: {
                sender.backgroundColor=UIColor.green
                
            }, completion: nil)
            //            sender.backgroundColor=UIColor.green
        } else {
            print("WRONG")
            UIView.transition(with: sender,
                              duration: 0.5,
                              options: .allowUserInteraction,
                              animations: {
                sender.backgroundColor=UIColor.red
                
            }, completion: nil)
            //            sender.backgroundColor=UIColor.red
        }
        lastChecker = quizBrain.checkLastQuestion()
        if lastChecker == true {
            SPConfetti.startAnimating(.fullWidthToDown, particles: [.triangle,.circle,.polygon], duration: 5)
        } else {
            
        }
        quizBrain.nextQuestion()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(uiUpdate), userInfo: nil, repeats: false)
    }
    
    @objc func uiUpdate() {
        
        barProgress.progress=quizBrain.getProgress()
        questionText.text=quizBrain.getQuestionText()
        scoreLabel.text="Score \(quizBrain.getScore())"
        trueButton.backgroundColor=UIColor.clear
        falseButton.backgroundColor=UIColor.clear
    }
}




import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var barProgress: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    var timer=Timer()
    var quizBrain=QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        uiUpdate()
        
        let userAnswer=sender.currentTitle!
        let userGotItRight=quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            UIView.transition(with: sender,
                                      duration: 0.1,
                                      options: .transitionFlipFromLeft,
                                      animations: {
                                        sender.backgroundColor=UIColor.green

                    }, completion: nil)
            sender.backgroundColor=UIColor.green
        }else{
            UIView.transition(with: sender,
                                      duration: 0.1,
                                      options: .transitionFlipFromLeft,
                                      animations: {
                                        sender.backgroundColor=UIColor.red

                    }, completion: nil)
            sender.backgroundColor=UIColor.red
        }
        quizBrain.nextQuestion() 
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(uiUpdate), userInfo: nil, repeats: true)
    }
    @objc func uiUpdate() {
        
        barProgress.progress=quizBrain.getProgress()
        questionText.text=quizBrain.getQuestionText()
        scoreLabel.text="Score \(quizBrain.getScore())"
        trueButton.backgroundColor=UIColor.clear
        falseButton.backgroundColor=UIColor.clear
    }
}


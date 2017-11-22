//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by gmhding on 11/21/17.
//  Copyright © 2017 gmhding. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var totalQuestion = Int()
    var currentQuestion = 1
    var score = 0
    var correctAnswer = "Answer 1"
    var answer = ""
    var qText = ""
    var questions = [Dictionary<String, AnyObject>]()
    
    @IBOutlet weak var caText: UILabel!
    @IBOutlet weak var rwText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    
    @IBAction func nextPressed(_ sender: Any) {
        nextScreen()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        homeScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionText.text = qText
        caText.lineBreakMode = .byWordWrapping
        caText.numberOfLines = 0;
        caText.text = "Correct answer: " + correctAnswer
        if (answer == correctAnswer) {
            score += 1
            rwText.text = "You answer it right!"
        } else {
            rwText.text = "You answer ir wrong!"
        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(AnswerViewController.swipedR(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(AnswerViewController.swipedL(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func swipedR(_ gesture: UIGestureRecognizer) {
        nextScreen()
    }
    
    func swipedL(_ gesture: UIGestureRecognizer) {
        homeScreen()
    }
    
    func nextScreen() {
        if currentQuestion < totalQuestion {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
            self.navigationController?.pushViewController(vc, animated: true)
            currentQuestion += 1
            vc.currentQuestion = currentQuestion
            vc.score = score
            vc.questions = questions
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinishViewController") as! FinishViewController
            vc.totalscore = totalQuestion
            vc.scores = score
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func homeScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
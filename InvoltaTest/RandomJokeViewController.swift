//
//  RandomJokeViewController.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import UIKit

class RandomJokeViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var punchlineLabel: UILabel!
    
    var modelJoke = RandomJokeViewModel()
    var modelJokes = MoreJokesViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idLabel.textColor = .systemYellow
        
        modelJoke.loadRandomJoke { [self] message in
            DispatchQueue.main.async {
                if message == nil {
                    self.idLabel.text = "Id: " + String(modelJoke.joke.id)
                    self.typeLabel.text = "Type: " + modelJoke.joke.type
                    self.setupLabel.text = modelJoke.joke.setup
                    self.punchlineLabel.text = modelJoke.joke.punchline
                } else {
                    if modelJokes.allJokes.count > 0 {
                        if let joke = modelJokes.allJokes.randomElement() {
                            modelJoke.joke = joke
                            self.idLabel.text = "Id: " + String(modelJoke.joke.id)
                            self.typeLabel.text = "Type: " + modelJoke.joke.type
                            self.setupLabel.text = modelJoke.joke.setup
                            self.punchlineLabel.text = modelJoke.joke.punchline
                            self.title = "Шутка из заначки"
                        } else {
                            self.idLabel.textColor = .systemYellow
                            self.idLabel.text = message
                            self.typeLabel.isHidden = true
                            self.setupLabel.isHidden = true
                            self.punchlineLabel.isHidden = true
                        }
                    } else {
                        self.idLabel.textColor = .systemYellow
                        self.idLabel.text = message
                        self.typeLabel.isHidden = true
                        self.setupLabel.isHidden = true
                        self.punchlineLabel.isHidden = true
                    }
                }
            }
        }
        
    }
    
}

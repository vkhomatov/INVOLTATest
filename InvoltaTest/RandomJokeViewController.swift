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
    @IBOutlet weak var titleLabel: UILabel!
    
    var modelJoke = RandomJokeViewModel()
    var modelJokes = MoreJokesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idLabel.textColor = .systemYellow
        self.titleLabel.text = "Random Joke"
        self.typeLabel.isHidden = false
        self.setupLabel.isHidden = false
        self.punchlineLabel.isHidden = false
        
        modelJoke.loadRandomJoke { [weak self] message in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if message == nil {
                    self.idLabel.text = "Id: " + String(self.modelJoke.joke.id)
                    self.typeLabel.text = "Type: " + self.modelJoke.joke.type
                    self.setupLabel.text = self.modelJoke.joke.setup
                    self.punchlineLabel.text = self.modelJoke.joke.punchline
                } else {
                    if self.modelJokes.allJokes.count == 0 {
                        self.modelJokes.allJokes = self.modelJokes.udService.loadJokes()
                    }
                    if self.modelJokes.allJokes.count > 0 {
                        if let joke = self.modelJokes.allJokes.randomElement() {
                            self.modelJoke.joke = joke
                            self.idLabel.text = "Id: " + String(self.modelJoke.joke.id)
                            self.typeLabel.text = "Type: " + self.modelJoke.joke.type
                            self.setupLabel.text = self.modelJoke.joke.setup
                            self.punchlineLabel.text = self.modelJoke.joke.punchline
                            self.titleLabel.text = "Шутка из заначки"
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

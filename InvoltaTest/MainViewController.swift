//
//  ViewController.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let modelMain = MainViewModel()
    private let modelJokes = MoreJokesViewModel()
    private let modelJoke = RandomJokeViewModel()


    @IBOutlet weak var randomImageView: UIImageView!
    @IBOutlet weak var showMoreJokeButton: UIButton!
    @IBOutlet weak var showRandomJokeButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Involta Test"
        self.errorLabel.isHidden = false
        self.errorLabel.text = "Загрузка ..."
        self.modelMain.getImagesHesh()
        self.loadImage(images: modelMain.imagesDictionary)
    }
    
    @IBAction func showRandomJokeButtonPress(_ sender: UIButton) {
        
    }
    
    @IBAction func showMoreJokeButtonPress(_ sender: UIButton) {        
        
    }
    
    func loadImage(images: [Int : String]) {
        guard let randomImage = images.randomElement() else { return }
        if let image = modelMain.udService.readImage(key: randomImage.key) {
            randomImageView.image = image
        } else {
                self.modelMain.loadImageFromUrl(string: randomImage.value) { [weak self] image, message in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        if message == nil {
                            if let picture = image {
                                self.errorLabel.isHidden = true
                                self.randomImageView.image = picture
                                self.modelMain.udService.saveImage(key: randomImage.key, string: randomImage.value, image: picture)
                            }
                        } else {
                            self.errorLabel.text = message
                        }
                    }
                }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let mainViewController = segue.source as? MainViewController else { return }

        
        if segue.identifier == "showManyJokes" {
            guard let moreJokesViewController = segue.destination as? MoreJokesViewController else { return }
            moreJokesViewController.model = mainViewController.modelJokes
        }
        if segue.identifier == "showRandomJoke" {
            guard let randomJokeViewController = segue.destination as? RandomJokeViewController else { return }
            randomJokeViewController.modelJokes = mainViewController.modelJokes
        }
        
    }
    
   
}


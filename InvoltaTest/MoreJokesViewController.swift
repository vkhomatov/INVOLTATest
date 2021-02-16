//
//  MoreJokesViewController.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import UIKit

class MoreJokesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var jokesTableView: UITableView!
    var model = MoreJokesViewModel()
    var firstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokesTableView.delegate = self
        jokesTableView.dataSource = self
        
            self.title = "Loading ..."
            
            model.loadMoreJokes { [weak self] message in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if message == nil {
                        self.model.allJokes = self.model.jokes
                        self.jokesTableView.reloadData()
                        self.title = "More More Jokes"
                        self.model.udService.saveJokes(jokes: self.model.allJokes)
                    } else {
                        if self.model.allJokes.count == 0 {
                            self.model.allJokes = self.model.udService.loadJokes()
                            self.jokesTableView.reloadData()
                        }
                        if self.model.allJokes.count > 0 {
                            self.title = "Заначка с шутками"
                            self.jokesTableView.reloadData()
                        }
                        else {
                            self.title = message
                        }
                    }
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.model.allJokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jokecell", for: indexPath) as? JokeTableViewCell else { return UITableViewCell() }
        
        if self.model.allJokes.count > indexPath.row {
            cell.idLabel.text = "Id: " + String(model.allJokes[indexPath.row].id)
            cell.typeLabel.text = "Type: " + model.allJokes[indexPath.row].type
            cell.setupLabel.text = model.allJokes[indexPath.row].setup
            cell.punchlineLabel.text = model.allJokes[indexPath.row].punchline
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == model.allJokes.count {
            if !self.firstTime {
                self.title = "Loading ..."
                self.model.loadMoreJokes { [self] message in
                    DispatchQueue.main.async {
                        if message == nil {
                            for newjoke in model.jokes {
                                if !model.allJokes.contains(newjoke) {
                                    model.allJokes.append(newjoke)
                                }
                            }
                            self.jokesTableView.reloadData()
                            self.title = "More More Jokes"
                            self.model.udService.saveJokes(jokes: model.allJokes)
                            
                        } else if self.model.allJokes.count > 0 {
                            self.title = "Заначка с шутками"
                        }
                    }
                }
                
            }
            self.firstTime = false
        }
    }
    
}

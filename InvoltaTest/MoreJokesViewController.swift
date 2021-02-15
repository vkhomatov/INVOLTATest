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
        self.title = "More More Jokes"
        
        if model.allJokes.count == 0 {
            self.title = "Loading ..."
            
            model.loadMoreJokes { [self] message in
                DispatchQueue.main.async {
                    if message == nil {
                        model.allJokes = model.jokes
                        self.title = "More More Jokes"
                        self.jokesTableView.reloadData()
                    } else {
                        model.allJokes = model.udService.loadJokes()
                        if model.allJokes.count > 0 {
                            self.jokesTableView.reloadData()
                            self.title = "Сохраненнные шутки"
                        } else {
                            self.title = message
                        }
                    }
                }
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        model.udService.saveJokes(jokes: model.allJokes)
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
                            self.title = "More More Jokes"
                            self.jokesTableView.reloadData()
                        } else {
                            self.title = message
                        }
                    }
                }
                
            }
            self.firstTime = false
        }
    }
    
}

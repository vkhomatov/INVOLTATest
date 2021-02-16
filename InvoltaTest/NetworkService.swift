//
//  NetworkService.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import Foundation
import UIKit


final class NetworkService {
    
    //    Grab a random joke!
    //    https://official-joke-api.appspot.com/random_joke
    //    https://official-joke-api.appspot.com/jokes/random
    //
    //    Grab ten random jokes!
    //    https://official-joke-api.appspot.com/random_ten
    //    https://official-joke-api.appspot.com/jokes/ten
    
    let session = URLSession.shared
    var urlConstructor = URLComponents()
    
    func getRandomJoke(completion: @escaping (Swift.Result<Joke, Error>?, String?) -> Void)  {
        urlConstructor.scheme = "https"
        urlConstructor.host = "official-joke-api.appspot.com"
        urlConstructor.path = "/jokes/random"
        if let url = urlConstructor.url {
            session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
                if let data = data,
                   let pryaniki = try? JSONDecoder().decode(Joke.self, from: data) {
                    completion(.success(pryaniki), nil)
                } else if let error = error  {
                    completion(.failure(error), nil)
                } else if let httpResponse = response as? HTTPURLResponse {
                    completion(nil, httpResponse.statusCode.description)
                }
            }.resume()
        } else {
            print("Неверный формат URL")
        }
    }
    
    func getMoreJokes(completion: @escaping ((Swift.Result<[Joke], Error>?, String?) -> Void))  {
        urlConstructor.scheme = "https"
        urlConstructor.host = "official-joke-api.appspot.com"
        urlConstructor.path = "/jokes/ten"
        if let url = urlConstructor.url {
            session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
                if let data = data,
                   let jokes = try? JSONDecoder().decode([Joke].self, from: data) {
                    completion(.success(jokes), nil)
                } else if let error = error  {
                    completion(.failure(error), nil)
                } else if let httpResponse = response as? HTTPURLResponse {
                    completion(nil, httpResponse.statusCode.description)
                }
            }.resume()
        } else {
            print("Неверный формат URL")
        }
    }
    
    func getData(string : String, completion: @escaping (Swift.Result<Data, Error>?, String?) -> Void)  {
        if let url = URL(string: string) {
            session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
                if let data = data {
                    completion(.success(data), nil)
                } else if let error = error  {
                    completion(.failure(error), nil)
                } else if let httpResponse = response as? HTTPURLResponse {
                    completion(nil, httpResponse.statusCode.description)
                }
            }.resume()
        } else {
            print("Неверный формат URL")
        }
    }
    
    
}

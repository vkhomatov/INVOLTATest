//
//  MoreJokesViewModel.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import Foundation
import UIKit


class MoreJokesViewModel {
    
    
    private let networkService = NetworkService()
    let udService = UDService()
    var jokes = [Joke]()
    var allJokes = [Joke]()
    
    func loadMoreJokes(completion: @escaping (String?) -> ()) {
        networkService.getMoreJokes { [weak self] result, message  in
            guard let self = self else { return }
            switch result {
            case let .success(jokes):
                self.jokes = jokes
                print(#function + " данные успешно загружены")
                    completion(nil)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription), не удалось загрузить данные")
                    completion(error.localizedDescription)
            case .none:
                print("Ошибка сервера: \(message ?? "Unknown"), не удалось загрузить данные")
                    completion(message)
            }
        }
    }
    
}
//
//  RandomJokeViewModel.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 16.02.2021.
//

import Foundation

class RandomJokeViewModel {
    
    var joke = Joke()
    private let networkService = NetworkService()
    
    // загрузка рэндомной шутки
    func loadRandomJoke(completion: @escaping (String?) -> ()) {
        networkService.getRandomJoke { [weak self] result, message  in
            guard let self = self else { return }
            switch result {
            case let .success(joke):
                self.joke = joke
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

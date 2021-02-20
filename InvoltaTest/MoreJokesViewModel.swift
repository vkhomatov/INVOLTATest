//
//  MoreJokesViewModel.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import Foundation

class MoreJokesViewModel {
    
    private let networkService = NetworkService()
    var udService = UDService()
    var jokes = [Joke]()
    var allJokes = [Joke]()
    var isLoading: Bool = true

    
    // загрузка 10-ти шуток
    func loadMoreJokes(completion: @escaping (String?) -> ()) {
        self.isLoading = true
        networkService.getMoreJokes { [weak self] result, message  in
            guard let self = self else { return }
            switch result {
            case let .success(jokes):
                self.jokes = jokes
                print(#function + " данные успешно загружены")
                self.isLoading = false
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

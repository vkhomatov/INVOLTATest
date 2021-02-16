//
//  MainViewModel.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import UIKit

class MainViewModel {
    
    private let networkService = NetworkService()
    let udService = UDService()
    
    private let pictureUrls = ["https://i.ytimg.com/vi/XWJO_oHk8o0/maxresdefault.jpg",
                               "https://prozarplaty.ru/wp-content/uploads/2019/06/kakuju-zarplatu-poluchajut-programmisty.jpg",
                               "https://pokadepressiya.ru/wp-content/uploads/f/5/a/f5ad341e49746367b4c3627dbeda98e9.jpg",
                               "https://hr-portal.ru/files/mini/15-53.jpg",
                               "https://cs-msk-fd-4.ykt2.ru/media/upload/photo/2019/05/20/26e5a8ab-7db6-487d-9224-965d4eb8bb04.jpeg"]
    
    var imagesDictionary = [Int : String]()
    
    private var image = UIImage()
    
    func getImagesHesh() {
        pictureUrls.forEach { url in
            imagesDictionary.updateValue(url, forKey:  url.hash)
        }
    }
    
    
    func loadImageFromUrl(string: String, completion: @escaping (UIImage?, String?) -> ()) {
        networkService.getData(string: string) { [weak self] result, message  in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print(data)
                if let image = UIImage(data: data) {
                    self.image = image
                    print("Картинка успешно загружена")
                    completion(image, nil)
                } else {
                    completion(nil, "Ошибка закрузки картинки")
                }
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription), не удалось загрузить данные")
                completion(nil, error.localizedDescription)
            case .none:
                print("Ошибка сервера: \(message ?? "Unknown"), не удалось загрузить данные")
                completion(nil, message)
            }
        }
        
    }
    
    func animationView(view: UIView, duration: Double, delay: Double,  offsetY: CGFloat, opacity: Float) {
        UIView.animate(withDuration: duration, delay: delay, animations: {
            view.frame = view.frame.offsetBy(dx: 0, dy: offsetY)
            view.layer.opacity = opacity
        }) { (finish) in
            print("Анимация view завершена")
        }
    }
    
}

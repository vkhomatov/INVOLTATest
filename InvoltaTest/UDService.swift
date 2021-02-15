//
//  UDService.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import Foundation
import UIKit


final class UDService {
    
    private let defaults = UserDefaults.standard
    private let filemanager = FileManager.default
    
    func readImage(key: Int) -> UIImage? {
        if let filename = defaults.object(forKey: String(key)) as? String {
            print(#function + ": FILENAME = \(filename) найден в UD")
          //  filename.description
            if let image = UIImage(contentsOfFile: filename.description) {
                print(#function + ": файл \(filename) загружен из UD")
                print(image)
                return image
            }
        } else {
            print(#function + ": файл с ключом \(key) в UD не обнаружен")
        }
        return nil
    }
    
    func saveImage(key: Int, string: String, image: UIImage) {
        if let data = image.jpegData(compressionQuality: 100) {
            let filename = getImagesDirectory().appendingPathComponent(URL.init(fileURLWithPath: string).lastPathComponent)
            if let _ = try? data.write(to: filename) {
                defaults.setValue(filename.absoluteString, forKey: String(key))
                print(#function + ": запись файла \(filename) прошла успешно")
            } else {
                print(#function + ":  ОШИБКА записи файла \(filename)")
            }
        } else {
            print(#function + ":  ОШИБКА записи файла \(string)")
        }
    }
    
    private func getImagesDirectory(directoryName: String = "RandomImages") -> URL {
        let paths = filemanager.urls(for: .documentDirectory, in: .userDomainMask)
        let imagesPath = paths[0].appendingPathComponent(directoryName)
        try? filemanager.createDirectory(atPath: imagesPath.path, withIntermediateDirectories: true, attributes: nil)
        return imagesPath
    }
    
    func saveJokes(jokes: [Joke]) {
        if jokes.count > 0 {
           // defaults.set(jokes.count, forKey: "jokesCount")
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(jokes) {
                defaults.set(encoded, forKey: "Jokes")
                print(#function + ": \(jokes.count) шуток сохранены в UD")
            }
        }
    }
    
    func loadJokes() -> [Joke] {
        if let savedJokes = defaults.object(forKey: "Jokes") as? Data {
            let decoder = JSONDecoder()
            if let loadedJokes = try? decoder.decode([Joke].self, from: savedJokes) {
                print(#function + ": \(loadedJokes.count) шуток загружены из UD")
                return loadedJokes
            }
        }
        return [Joke]()
    }
    

}

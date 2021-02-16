//
//  UDService.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import UIKit

// работа с UserDefaults и файлами
final class UDService {
    
    private let defaults = UserDefaults.standard
    private let filemanager = FileManager.default
    
    /*  func readImage(key: Int) -> UIImage? {
        if let filename = defaults.object(forKey: String(key)) as? String {
            print(#function + ": FILENAME = \(filename) найден в UserDefuults, ключ \(String(key))")

//            let fullpath = getImagesDirectory().absoluteURL.appendingPathComponent(filename)
//            print(#function + ": FILEPATH = \(fullpath.absoluteString)")


            if let image = UIImage(contentsOfFile: filename) {
                print(#function + ": файл \(filename) загружен из UserDefuults")
                print(image)
                return image
            }
        } else {
            print(#function + ": файл с ключом \(key) в UserDefuults не обнаружен")
        }
        return nil
    } */
    
    func readImage(key: Int) -> UIImage? {
        if let filename = defaults.object(forKey: String(key)) as? String {
            print(#function + ": FILENAME = \(filename) найден в UserDefuults, ключ \(String(key))")

            let fullpath = getImagesDirectory().absoluteURL.appendingPathComponent(filename)
            print(#function + ": FILEPATH = \(fullpath.absoluteString)")
            
            if let pngUrl = URL.init(string: fullpath.absoluteString) {
                if let data = try? Data.init(contentsOf: pngUrl) {
                  let photo = UIImage.init(data: data)
                    print(#function + ": файл \(fullpath.absoluteString) загружен из UserDefuults")
                  return photo
                }
            }
        } else {
            print(#function + ": файл с ключом \(key) в UserDefuults не обнаружен")
        }
        return nil
    }
    
    func saveImage(key: Int, string: String, image: UIImage) {
        if let data = image.jpegData(compressionQuality: 100) {
            let filename = getImagesDirectory().absoluteURL.appendingPathComponent(URL.init(fileURLWithPath: string).lastPathComponent)

            if let _ = try? data.write(to: filename) {
                defaults.setValue(filename.lastPathComponent, forKey: String(key))
                print(#function + ": запись файла \(filename.absoluteString)\nпрошла успешно, ключ \(String(key))")
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
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(jokes) {
                defaults.set(encoded, forKey: "Jokes")
                print(#function + ": \(jokes.count) шуток сохранены в UserDefuults")
            }
        }
    }
    
    func loadJokes() -> [Joke] {
        if let savedJokes = defaults.object(forKey: "Jokes") as? Data {
            let decoder = JSONDecoder()
            if let loadedJokes = try? decoder.decode([Joke].self, from: savedJokes) {
                print(#function + ": \(loadedJokes.count) шуток загружены из UserDefuults")
                return loadedJokes
            }
        }
        return [Joke]()
    }
    
    
}

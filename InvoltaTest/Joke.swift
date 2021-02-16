//
//  Joke.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import Foundation

//"id": 89,
//"type": "general",
//"setup": "Did you hear about the cow who jumped over the barbed wire fence?",
//"punchline": "It was udder destruction."

struct Joke: Codable, Equatable {
    static func == (lhs: Joke, rhs: Joke) -> Bool {
        return lhs.id == rhs.id
    }
    var id = Int()
    var type = String()
    var setup = String()
    var punchline = String()
}

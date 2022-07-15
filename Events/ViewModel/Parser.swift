//
//  Parser.swift
//  Events
//
//  Created by Joshua on 11/07/2022.
//

import Foundation

struct Constants {
    static let apiURL = "https://5d1dae5d3374890014f005d1.mockapi.io/api/v1/"
}

enum ServiceEndPoint: String {
    case home = "home"
    case events = "events"
}

struct Parser {

    func parse(endPoint: ServiceEndPoint, comp:@escaping ([HomeModel])->()) {
        let api = Constants.apiURL + endPoint.rawValue
        guard let url = URL(string: api) else {
            return }

        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if error != nil {
                print(String(describing: error))
                return
            } else if data != nil {
                do {
                    let results = try JSONDecoder().decode(Home.self, from: data!)
                    comp(results.self)
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}

//
//  KaptenConnector.swift
//  kaptenWars
//
//  Created by daniel velasco on 13/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import Foundation

class KaptenConnector {
    fileprivate struct Constants {
        static let tripUrl = "https://starwars.kapten.com/trips/"
       }
       
    static func getTrips(completion: @escaping ([Trip]?) -> Void) {
        let url = URL(string: Constants.tripUrl)
        var urlRequest = URLRequest(url: url!)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
           
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("error=\(String(describing: error))")
                return
            }
               
            if let data = data {
                do {
                    let feeds = try JSONDecoder().decode([Trip].self, from: data)
                    completion(feeds)
                    return
                } catch {
                    print("trip Parsing Error, class KaptenConnector")
                }
            } else {
                print("No data recived: class KaptenConnector")
            }
           }
           task.resume()
       }
}

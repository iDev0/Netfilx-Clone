//
//  api.swift
//  Netfilx Clone
//
//  Created by iDev0 on 2020/07/09.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import Foundation

class Api {

    public static let shared = Api()
    
    public enum MoviePath : String {
        case nowPlaying = "/movie/now_playing"
    }
    
    
    
    public func getMovie(path : MoviePath, _ completion : @escaping (Data) -> Void) {
        get(path: path.rawValue, parameters: nil, { (data) in
            completion(data)
        })
    }
    
    
    
    // MARK: Private Methods
    
    private func get(path: String, parameters : Dictionary<String, String>?, _ completion : @escaping (Data) -> Void) {
        let request = createRequest(path: path, parameters: parameters)
        print(request)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print(error)
                return
            }
            
            completion(data!)
        }.resume()
    }

    private func createSession() -> URLSession {
        return URLSession(configuration: .default)
    }

    private func createRequest(path: String, parameters: Dictionary<String, String>?) -> URLRequest {
        var components = URLComponents(string: "https://api.themoviedb.org/3\(path)")
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "api_key", value: "24ca04c6a3c3f77dcd86b12fdef8c829"))
        
        if let parameters = parameters {
            if !parameters.isEmpty {
                for item in parameters {
                    queryItems.append(URLQueryItem(name: item.key, value: item.value))
                }
            }
        }
    
        components?.queryItems = queryItems
        return URLRequest(url: (components?.url)!)
    }
}


public struct NowPlaying : Codable {
    
    var results : [Result]
    
    struct Result : Codable {
        var id: Int
        var title: String
        var poster_path: String
    }
}







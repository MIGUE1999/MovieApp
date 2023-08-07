//
//  MovieStore.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import Foundation

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "d86551bcbbee12dda9766345f16c9c32"
    private let baseApiUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder

    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping ( MovieResponse?, MovieError?) -> ()) {
        
        guard let url = URL(string: "\(baseApiUrl)/movie/\(endpoint.rawValue)") else {
            completion(nil, .invalidEndpoint)
            return
        }
        
        self.loadURLAndDecodeArray(url: url, completion: completion)
    
    }
    
    func fetchMovie(id: Int, completion: @escaping (Movie?, MovieError?) -> ()) {
        guard let url = URL(string: "\(baseApiUrl)/movie/\(id)") else {
            completion(nil, .invalidEndpoint)
            return
        }
        self.loadURLAndDecode(url: url, params:  ["append_to_response": "videos, credits"], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (MovieResponse?, MovieError?) -> ()) {
        
        guard let url = URL(string: "\(baseApiUrl)/search/movie") else {
            completion(nil, .invalidEndpoint)
            return
        }
        
        self.loadURLAndDecodeArray(url: url, params:  [
            "query": query,
            "include_adult": "false",
            "language": "en-US"
        ], completion: completion)
         
    }
    
    private func loadURLAndDecode(url: URL, params: [String: String]? = nil, completion: @escaping (Movie?, MovieError?) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(nil, .invalidEndpoint)
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(nil, .invalidEndpoint)
            return
        }
        
        let task = urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                completion(nil, .apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data)
                completion(result, nil)
            } catch {
                print("Error decode: \(error)")
            }

            return
        }
        task.resume()
    }
    
    private func loadURLAndDecodeArray(url: URL, params: [String: String]? = nil, completion: @escaping (MovieResponse?, MovieError?) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(nil, .invalidEndpoint)
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(nil, .invalidEndpoint)
            return
        }
        
        let task = urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                completion(nil, .apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                
                completion(result, nil)
            } catch {
                print("Error decode: \(error)")
            }

            return
        }
        task.resume()
    }
    
}

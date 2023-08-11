//
//  Movie.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

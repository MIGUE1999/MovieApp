//
//  Movie.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let adult: Bool
    let posterPath: String
    let backdropPath: String?
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title, overview, adult
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

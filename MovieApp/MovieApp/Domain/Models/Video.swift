//
//  Video.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 9/8/23.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    let id: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let key: String
    let site: String
    let type: String
    let official: Bool

    enum CodingKeys: String, CodingKey {
        case key, site, type, official
    }
}

//
//  MockRepository.swift
//  MovieAppTests
//
//  Created by Tejada Ortigosa Miguel Angel on 10/8/23.
//

import Foundation
@testable import MovieApp

final class MockRespository: MovieService {
    
    func fetchMovies(from endpoint: MovieApp.MovieListEndpoint, completion: @escaping (MovieApp.MovieResponse?, MovieApp.MovieError?) -> ()) {
    }
    
    func fetchMovie(id: Int, completion: @escaping (MovieApp.Movie?, MovieApp.MovieError?) -> ()) {
    
    }
    
    func searchMovie(query: String, completion: @escaping (MovieApp.MovieResponse?, MovieApp.MovieError?) -> ()) {

    }
    
    func getTrailer(movieId: Int, completion: @escaping (MovieApp.Video?, MovieApp.MovieError?) -> ()) {
    
    }
    
    
    
}

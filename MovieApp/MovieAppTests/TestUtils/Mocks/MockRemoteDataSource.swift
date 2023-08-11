//
//  MockMovieStore.swift
//  MovieAppTests
//
//  Created by Tejada Ortigosa Miguel Angel on 11/8/23.
//

import Foundation
@testable import MovieApp

final class MockRemoteDataSource: MovieService {
    
    let moviesSuccess: Bool
    let videoSuccess: Bool
    
    init(moviesSuccess: Bool = false, videoSuccess: Bool = false) {
        self.moviesSuccess = moviesSuccess
        self.videoSuccess = videoSuccess
    }
    
    func fetchMovies(from endpoint: MovieApp.MovieListEndpoint, completion: @escaping (MovieApp.MovieResponse?, MovieApp.MovieError?) -> ()) {
        switch self.moviesSuccess{
        case true:
            completion(getEmptyStubMovieResponse(), nil)
        case false:
            completion(nil, .invalidResponse)
        }
    }
    
    func searchMovie(query: String, completion: @escaping (MovieApp.MovieResponse?, MovieApp.MovieError?) -> ()) {
        switch self.moviesSuccess{
        case true:
            completion(getEmptyStubMovieResponse(), nil)
        case false:
            completion(nil, .invalidResponse)
        }
    }
    
    func getTrailer(movieId: Int, completion: @escaping (MovieApp.Video?, MovieApp.MovieError?) -> ()) {
        switch self.videoSuccess{
        case true:
            completion(getEmptyStubVideo(), nil)
        case false:
            completion(nil, .invalidResponse)
        }
    }
    
    func getEmptyStubMovieResponse() -> MovieResponse {
        let movie = Movie( id: 0, title: "", overview: "", posterPath: "", voteAverage: 0.0)
        let movieResponse = MovieResponse(results: [movie])
        
        return movieResponse
    }
    
    func getEmptyStubVideo() -> Video {
        let result = Result(key: "", site: "", type: "", official: true)
        let video = Video(id: 0, results: [result])
        
        return video
    }
    
}

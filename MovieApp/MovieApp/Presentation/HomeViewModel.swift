//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import Foundation


final class HomeViewModel{
    
    private let movieStore: MovieService
    private let viewController: ViewController
    
    init(movieStore: MovieService, viewController: ViewController){
        self.movieStore = movieStore
        self.viewController = viewController
        self.fetchMovie(id: 346698)
        self.fetchMovies()
        self.searchMovie(query: "Barbie")
    }
    
    func fetchMovie(id: Int) {
        movieStore.fetchMovie(id: id) { movie, movieError in
            if(movie != nil) {
                print(movie!.title)
            } else {
                if(movieError != nil){
                    print("Movie Error detectado: \(String(describing: movieError?.localizedDescription))")
                } else {
                    print("ERROR RARO")
                }
            }
        }
    }
    
    func fetchMovies() {
        movieStore.fetchMovies(from: .popular){ movies, movieError in
            guard let movies = movies else {
                guard let movieError = movieError else { return }
                print(movieError)
                return
            }
            print("***************************")
            for movie in movies.results {
                print(movie.title)
            }
        }
    }
    
    func searchMovie(query: String) {
        movieStore.searchMovie(query: query){ movies, movieError in
            guard let movies = movies else {
                guard let movieError = movieError else { return }
                print(movieError)
                return
            }
            print("***************************")
            for movie in movies.results {
                print(movie.title)
            }
        }
    }
}

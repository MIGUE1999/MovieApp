//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 10/8/23.
//

import Foundation

final class SearchViewModel {
    
    private let movieStore: MovieService
    private let searchViewController: SearchViewController
    var searchMovies: MovieResponse?

    
    init(movieStore: MovieService, searchViewController: SearchViewController){
        self.movieStore = movieStore
        self.searchViewController = searchViewController
        //self.fetchMovie(id: 346698)
        self.searchMovie(query: "Barbie") {
            DispatchQueue.main.async {
                self.searchViewController.searchCollectionView.reloadData()
            }
        }
    }
    
    func searchMovie(query: String, completion: @escaping () -> () ) {
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
            
            self.searchMovies = movies
            completion()
        }
    }
}

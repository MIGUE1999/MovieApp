//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import Foundation

final class HomeViewModel {

    private let movieStore: MovieService
    private let homeViewController: HomeViewController
    var mostPopularMovies: MovieResponse?
    var topRatedMovies: MovieResponse?

    init(movieStore: MovieService, homeViewController: HomeViewController){
        self.movieStore = movieStore
        self.homeViewController = homeViewController
        self.fetchMovies(from: .popular){
            DispatchQueue.main.async {
                self.homeViewController.movieMostPopularCollectionView.reloadData()
            }
        }
                
        self.fetchMovies(from: .topRated){
            DispatchQueue.main.async {
                self.homeViewController.movieTopRatedCollectionView.reloadData()
            }
        }
    }

    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping () -> ()) {
        movieStore.fetchMovies(from: endpoint){ movies, movieError in
            guard let movies = movies else {
                guard let movieError = movieError else { return }
                print(movieError)
                return
            }

            switch endpoint {
            case .popular:
                self.mostPopularMovies = movies
            case .topRated:
                self.topRatedMovies = movies
            case .nowPlaying:
                print("not implemented")
            case .upcoming:
                print("not implemented")
            }
            
            completion()
        }
    }

    
}

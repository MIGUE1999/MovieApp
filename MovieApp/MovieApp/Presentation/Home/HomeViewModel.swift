//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import Foundation

final class HomeViewModel{

    private let movieStore: MovieService
    private let homeViewController: HomeViewController
    var mostPopularMovies: MovieResponse?
    var topRatedMovies: MovieResponse?

    init(movieStore: MovieService, homeViewController: HomeViewController){
        self.movieStore = movieStore
        self.homeViewController = homeViewController
        //self.fetchMovie(id: 346698)
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
        //self.searchMovie(query: "Barbie")
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

    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping () -> ()) {
        movieStore.fetchMovies(from: endpoint){ movies, movieError in
            guard let movies = movies else {
                guard let movieError = movieError else { return }
                print(movieError)
                return
            }
            
            for i in movies.results{
                print(i.overview)
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

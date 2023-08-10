//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 10/8/23.
//

import Foundation

final class MovieDetailViewModel{
    
    private let movieStore: MovieService
    private let movieDetailViewController: MovieDetailViewController
    var videoResults: [Result]?
    private var trailerKey: String?
    
    init(movieId: Int, movieStore: MovieService, movieDetailViewController: MovieDetailViewController){
        self.movieStore = movieStore
        self.movieDetailViewController = movieDetailViewController
        self.getTrailer(movieId: movieId){
            DispatchQueue.main.async {
                self.movieDetailViewController.playerView.load(withVideoId: self.trailerKey ?? "")
                print("FIN COMPLETION")
            }
        }
    }
    
    func getTrailer(movieId: Int, completion: @escaping () -> ()){
        movieStore.getTrailer(movieId: movieId){ video, movieError in
            guard let videos = video?.results else {
                guard let movieError = movieError else { return }
                print(movieError)
                return
            }
            
            for video in videos{
                if(video.type == "Trailer" && video.site == "YouTube"){
                    self.trailerKey = video.key
                }
                
                if(video.official && video.type == "Trailer" && video.site == "YouTube") {
                    print(video.key)
                    self.trailerKey = video.key
                }
            }
            completion()
        }
    }
}

//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 8/8/23.
//

import UIKit
import WebKit
import youtube_ios_player_helper
import Cosmos

class MovieDetailViewController: UIViewController {
    
    private let movie: Movie
    var movieDetailViewModel: MovieDetailViewModel?

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "God Father"
        return label
    }()
    
    private let overviewLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a mafia!"
        return label
    }()
        
    let playerView : YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        return playerView
    }()
    
    private let ratingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Valoración"
        return label
    }()
    
    private let ratingView : CosmosView = {
        let ratingView = CosmosView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.settings.totalStars = 10
        ratingView.settings.updateOnTouch = false
        return ratingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(playerView)
        view.addSubview(ratingLabel)
        view.addSubview(ratingView)
        
        configureContraints()
        
        print("Detail: \(movie.id)")
        configure()
        
    }
    
    private func setViewModel() {
        let movieStore = MovieStore.shared
        self.movieDetailViewModel = MovieDetailViewModel(movieId: movie.id, movieStore: movieStore, movieDetailViewController: self)
    }
    
    func configureContraints(){
    
        let playerViewConstraints = [
            playerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstratints = [
            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let ratingLabelConstraints = [
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ratingLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
        ]
                
        let ratingViewConstraints = [
            ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ratingView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 25),
        ]
        
        NSLayoutConstraint.activate(playerViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstratints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(ratingLabelConstraints)
        NSLayoutConstraint.activate(ratingViewConstraints)
    }
    
    func configure(){
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        ratingView.rating = movie.voteAverage
    }

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



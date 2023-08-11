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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(playerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(ratingView)
        
        configureContraints()
        
        configure()
        
    }
    
    private func setViewModel() {
        let movieStore = MovieStore.shared
        self.movieDetailViewModel = MovieDetailViewModel(movieId: movie.id, movieStore: movieStore, movieDetailViewController: self)
    }
    
    func configureContraints(){
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        let contentViewConstraints = [
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ]
        

        let playerViewConstraints = [
            playerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstratints = [
            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)

        ]
 
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            overviewLabel.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let ratingLabelConstraints = [
            ratingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
        ]
                
        let ratingViewConstraints = [
            ratingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 25),
        ]
    
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(playerViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstratints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(ratingLabelConstraints)
        NSLayoutConstraint.activate(ratingViewConstraints)
    }
    
    func configure(){
        titleLabel.text = movie.title
        if(movie.overview != "" ) {
            overviewLabel.text = movie.overview
        } else {
            overviewLabel.text = "Información no disponible en este momento"
        }
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



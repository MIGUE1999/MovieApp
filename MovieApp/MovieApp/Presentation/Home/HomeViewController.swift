//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
     var mostPopularLabel: UILabel = {
     let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.text = "Más Populares"
     label.font = .systemFont(ofSize: Constants.titleFontSize, weight: UIFont.Weight.medium)
     label.textColor = .white
     label.textAlignment = .center
     return label
     }()
     
     var movieMostPopularCollectionView: UICollectionView = {
     let flowLayout = UICollectionViewFlowLayout()
     flowLayout.scrollDirection = .horizontal
     
     let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
     collectionView.translatesAutoresizingMaskIntoConstraints = false
     collectionView.showsHorizontalScrollIndicator = false
     let spaceBetweenFirstAndLastCellAndCollectionView: CGFloat = 10 // Espacio entre la primera y ultima celda y el inicio y fin del UICollectionView
     collectionView.contentInset = UIEdgeInsets(top: 0, left: spaceBetweenFirstAndLastCellAndCollectionView, bottom: 0, right: spaceBetweenFirstAndLastCellAndCollectionView)
     
     collectionView.tag = 1
          
     return collectionView
     }()
     
     var topRatedLabel: UILabel = {
     let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.text = "Mejor Valoradas"
     label.font = .systemFont(ofSize: Constants.titleFontSize, weight: UIFont.Weight.medium)
     label.textColor = .white
     label.textAlignment = .center
     return label
     }()
     
     var movieTopRatedCollectionView: UICollectionView = {
     let flowLayout = UICollectionViewFlowLayout()
     flowLayout.scrollDirection = .horizontal
     
     let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
     collectionView.translatesAutoresizingMaskIntoConstraints = false
     collectionView.showsHorizontalScrollIndicator = false
     let spaceBetweenFirstAndLastCellAndCollectionView: CGFloat = 10 // Espacio entre la primera y ultima celda y el inicio y fin del UICollectionView
     collectionView.contentInset = UIEdgeInsets(top: 0, left: spaceBetweenFirstAndLastCellAndCollectionView, bottom: 0, right: spaceBetweenFirstAndLastCellAndCollectionView)
     collectionView.tag = 2
     
     return collectionView
     }()
     
     func setConstraintsMostPopularLabel() {
     // Constraints
     mostPopularLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
     mostPopularLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
     mostPopularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
     mostPopularLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
     }
     
     func setConstraintsMovieMostPopularCollectionView() {
     movieMostPopularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
     movieMostPopularCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
     movieMostPopularCollectionView.topAnchor.constraint(equalTo: mostPopularLabel.bottomAnchor).isActive = true
     movieMostPopularCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
     }
     
     func setConstraintsTopRatedLabel() {
     // Constraints
     topRatedLabel.topAnchor.constraint(equalTo: movieMostPopularCollectionView.bottomAnchor).isActive = true
     topRatedLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
     topRatedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
     topRatedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
     }
     
     func setConstraintsMovieTopRatedCollectionView() {
     movieTopRatedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
     movieTopRatedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
     movieTopRatedCollectionView.topAnchor.constraint(equalTo: topRatedLabel.bottomAnchor).isActive = true
     movieTopRatedCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
     }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        addSubviews()
        setupMoviesMostPopularCollectionView()
        setupMoviesTopRatedCollectionView()
    }
    
    private func setViewModel() {
        let movieStore = MovieStore.shared
        self.homeViewModel = HomeViewModel(movieStore: movieStore, homeViewController: self)
    }

    
    private func addSubviews(){
        view.addSubview(mostPopularLabel)
        setConstraintsMostPopularLabel()
        view.addSubview(movieMostPopularCollectionView)
        setConstraintsMovieMostPopularCollectionView()
        view.addSubview(topRatedLabel)
        setConstraintsTopRatedLabel()
        view.addSubview(movieTopRatedCollectionView)
        setConstraintsMovieTopRatedCollectionView()
        
    }
    
    func setupMoviesMostPopularCollectionView() {
        movieMostPopularCollectionView.delegate = self
        movieMostPopularCollectionView.dataSource = self
        // Register cell
        movieMostPopularCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
    }
    
    func setupMoviesTopRatedCollectionView() {
        movieTopRatedCollectionView.delegate = self
        movieTopRatedCollectionView.dataSource = self
        // Register cell
        movieTopRatedCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case Constants.mostPopularCollectionViewTag:
            return homeViewModel?.mostPopularMovies?.results.count ?? 0
        case Constants.topRatedCollectionViewTag:
            return homeViewModel?.topRatedMovies?.results.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        var movie: Movie?
        
        switch collectionView.tag{
        case 1:
            movie = homeViewModel?.mostPopularMovies?.results[indexPath.row]
        case 2:
            movie = homeViewModel?.topRatedMovies?.results[indexPath.row]
        default:
            return cell
        }
        
        guard let movie = movie else { return cell }
        if let imageURL = URL(string: Constants.imageEndpoint + movie.posterPath) {
            cell.posterImageView.setImage(url: imageURL)
        } else {
            cell.posterImageView.image = UIImage(named: "prueba")
        }
        
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie: Movie?
        
        switch collectionView.tag{
        case Constants.mostPopularCollectionViewTag:
            movie = homeViewModel?.mostPopularMovies?.results[indexPath.row]
        case Constants.topRatedCollectionViewTag:
            movie = homeViewModel?.topRatedMovies?.results[indexPath.row]
        default:
            return
        }
        
        guard let movie = movie else { return }
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumInteritemSpacingForSection
    }
}


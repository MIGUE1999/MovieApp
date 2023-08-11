//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 8/8/23.
//

import UIKit


class SearchViewController: UIViewController {
        
    var searchViewModel: SearchViewModel?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var searchCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        let spaceBetweenFirstAndLastCellAndCollectionView: CGFloat = 10 // Espacio entre la primera y ultima celda y el inicio y fin del UICollectionView
        collectionView.contentInset = UIEdgeInsets(top: spaceBetweenFirstAndLastCellAndCollectionView, left: 0, bottom: spaceBetweenFirstAndLastCellAndCollectionView, right: 0)
        
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        setupSearchController()
        view.addSubview(searchCollectionView)
        setupSearchCollectionView()
        setConstraintsSearchCollectionView()
    }
    
    private func setViewModel() {
        let movieStore = MovieStore.shared
        self.searchViewModel = SearchViewModel(movieStore: movieStore, searchViewController: self)
    }
    
    func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Buscar películas por titulo"
        
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setConstraintsSearchCollectionView() {
        searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupSearchCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        // Register cell
        searchCollectionView.register(MovieTableViewCell.self, forCellWithReuseIdentifier: MovieTableViewCell.identifier)
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel?.searchMovies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        guard let movie = searchViewModel?.searchMovies?.results[indexPath.row] else { return cell }
        
        if let imageURL = URL(string: Constants.imageEndpoint + movie.posterPath) {
            cell.posterImageView.setImage(url: imageURL)
        } else {
            cell.posterImageView.image = UIImage(named: "prueba")
        }
                
        cell.titleLabel.text = movie.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("enn")
        guard let movie = searchViewModel?.searchMovies?.results[indexPath.row] else { return }
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.cellSearchSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumInteritemSpacingForSection
    }
}

// Mark: - Search Controller Functions
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
        searchViewModel?.searchMovie(query: searchController.searchBar.text ?? "") {
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        }
    }
}

//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 8/8/23.
//

import UIKit


class SearchViewController: UIViewController {
    
    let titles = ["PELI1", "PELI2", "PELI3", "PELI4", "PELI5"]
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        let spaceBetweenFirstAndLastCellAndCollectionView: CGFloat = 10 // Espacio entre la primera y ultima celda y el inicio y fin del UITableView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupSearchTableView()
        addSearchTableConstraints()
    }
    
    func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Buscar peliculas por titulo"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupSearchTableView() {
        searchTableView.dataSource = self
        searchTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    func addSearchTableConstraints() {
        view.addSubview(searchTableView)
        
        NSLayoutConstraint.activate([
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.topAnchor.constraint(equalTo: view.topAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    
}

// Mark: - TableView Functions

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier , for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        
        let title = titles[indexPath.row]
        cell.titleLabel.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         tableView.deselectRow(at: indexPath, animated: true)
         let title = titles[indexPath.row]
         guard let titleName = title.original_title ?? title.original_name else {return}
         ApiCaller.shared.getMovie(with: titleName) { [weak self] result in
         switch result {
         case .success(let videoElement):
         DispatchQueue.main.async {
         let vc = TitlePreviewViewController()
         vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
         self?.navigationController?.pushViewController(vc, animated: true) // herhangi bir satira tikladiginda detay sayfasina gidecel
         }
         case .failure(let error):
         print(error.localizedDescription)
         }
         }
         */
    }
}


// Mark: - Search Controller Functions
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}


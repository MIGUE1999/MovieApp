//
//  ViewController.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    var homeViewModel: HomeViewModel?
    private let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    private let cellReuseIdentifier = "CustomCollectionViewCell"
    
    var mostPopularLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Más Populares"
        label.font = .systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.backgroundColor = .red
        return label
    }()
    
    func setConstraintsMostPopularLabel() {
        // Constraints
        mostPopularLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mostPopularLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        mostPopularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mostPopularLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        addSubviews()
    }
    
    private func setViewModel() {
        let movieStore = MovieStore.shared
        self.homeViewModel = HomeViewModel(movieStore: movieStore, viewController: self)
    }
    
    private func addSubviews(){
        view.addSubview(mostPopularLabel)
        setConstraintsMostPopularLabel()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        // Constraints
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: mostPopularLabel.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register cell
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        let spaceBetweenFirstAndLastCellAndCollectionView: CGFloat = 10 // Espacio entre la primera y ultima celda y el inicio y fin del UICollectionView
        collectionView.contentInset = UIEdgeInsets(top: 0, left: spaceBetweenFirstAndLastCellAndCollectionView, bottom: 0, right: spaceBetweenFirstAndLastCellAndCollectionView)
        
        collectionView.backgroundColor = .gray
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.titleLabel.text = items[indexPath.item]
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

class CustomCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        
        layer.cornerRadius = 10 // Ajusta este valor según el redondeo deseado
        layer.masksToBounds = true
        
        // Constraints
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


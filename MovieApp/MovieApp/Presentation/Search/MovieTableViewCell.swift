//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 9/8/23.
//

import UIKit

class MovieTableViewCell: UICollectionViewCell{
    
    static let identifier = "MovieTableViewCell"
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
}

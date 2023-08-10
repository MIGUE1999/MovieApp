//
//  CustomCollectionViewCell.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 8/8/23.
//
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        layer.masksToBounds = true
        
        //setLabelConstraints()
        setImageConstraints()
    }
    
    func setLabelConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setImageConstraints() {
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

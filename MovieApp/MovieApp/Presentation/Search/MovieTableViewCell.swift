//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 9/8/23.
//

import UIKit


class MovieTableViewCell: UITableViewCell{
    
    static let identifier = "MovieTableViewCell"

    let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue

        return label
    }()
    
    let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(titlesPosterUIImageView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(playTitleButton)
            
            applyConstraints()
            
        }
        
    required init?(coder: NSCoder) {
            fatalError()
        }
        
        private func applyConstraints() {
            let titlesPosterUIImageViewConstraints = [
                titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100),
                titlesPosterUIImageView.heightAnchor.constraint(equalToConstant: 150)
            ]
            
            
            let titleLabelConstraints = [
                titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
                titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ]
            
            
            let playTitleButtonConstraints = [
                playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
            
            NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
            NSLayoutConstraint.activate(titleLabelConstraints)
            NSLayoutConstraint.activate(playTitleButtonConstraints)
        }
        
}

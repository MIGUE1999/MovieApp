//
//  Constants.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 8/8/23.
//

import Foundation

struct Constants {
    static let titleFontSize = CGFloat(25)
    static let cellReuseIdentifier = "CustomCollectionViewCell"
    static var cellSize = CGSize(width: 150, height: 250)
    static let minimumInteritemSpacingForSection: CGFloat = 10
    static let imageEndpoint = "https://image.tmdb.org/t/p/w500"
    static let mostPopularCollectionViewTag = 1
    static let topRatedCollectionViewTag = 2
 }

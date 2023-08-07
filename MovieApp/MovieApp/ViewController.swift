//
//  ViewController.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import UIKit

class ViewController: UIViewController {

    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
    }
    
    private func setViewModel() {
        let movieStore = MovieStore.shared
        self.homeViewModel = HomeViewModel(movieStore: movieStore, viewController: self)
    }


}


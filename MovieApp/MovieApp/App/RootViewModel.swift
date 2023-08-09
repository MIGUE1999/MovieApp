//
//  RootViewModel.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 8/8/23.
//

import Foundation

enum Status {
    case home, detail
}

final class RootViewModel {
    
    var activeView: Status = .home {
        didSet {
            print("New value of activeView is \(activeView)")
            if oldValue != activeView {
                self.onViewChange?()
            }
        }
    }
    
    var onViewChange: (() -> Void)?
}

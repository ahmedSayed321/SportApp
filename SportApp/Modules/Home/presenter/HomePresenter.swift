//
//  HomePresenter.swift
//  SportApp
//
//  Created by AndrewMagdy on 02/05/2026.
//

import Foundation

// HomePresenter.swift
class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getSports() -> [SportType] {
        return SportType.allSports
    }
}

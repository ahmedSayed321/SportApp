//
//  LeagueDetailsViewController.swift
//  SportApp
//
//  Created by Me3bed on 05/05/2026.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    let indicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator.center = view.center
        indicator.color = .white
        view.addSubview(indicator)
    }
    

   

}

extension LeagueDetailsViewController : LeagueEventsViewProtocol{
    func didFetchLeaguesEvents() {
        <#code#>
    }
    
    func didFailWithError(_ error: String) {
        <#code#>
    }
    
    func showLoading() {
        indicator.startAnimating()
    }
    
    func hideLoading() {
        indicator.stopAnimating()

    }
}

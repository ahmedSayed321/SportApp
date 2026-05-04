//
//  LeagueViewController.swift
//  SportApp
//
//  Created by Me3bed on 04/05/2026.
//

import UIKit

class LeagueViewController: UIViewController {

    var presenter : LeaguesPresenterProtocol?
    var sport : SportType? = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomLeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomLeagueTableViewCell")
        
        if let sport = sport {
            presenter?.fetchLeagues(for: sport)
        }
        


    }
    
    
    func startLoading(){
        
    }
    
    func stopLoading(){
        
    }



}

extension LeagueViewController : LeaguesViewProtocol{
    func didFetchLeagues() {
        DispatchQueue.main.async {
             self.tableView.reloadData()
            }
    }
    
    func didFailWithError(_ error: String) {
        print("...")
    }
    
    func showLoading() {
        startLoading()
    }
    
    func hideLoading() {
        stopLoading()
    }
}

extension LeagueViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getLeaguesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomLeagueTableViewCell", for: indexPath) as! CustomLeagueTableViewCell
        
        
        if let league = presenter?.getLeague(at: indexPath.row) {
                cell.setOutlets(league)
            }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


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
    let indicator = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.searchTextField.textColor = .white
        
        searchBar.searchTextField.leftView?.tintColor = .white
        
        indicator.center = view.center
        indicator.color = .white
        view.addSubview(indicator)
        
        view.backgroundColor = UIColor(red: 0.08, green: 0.10, blue: 0.16, alpha: 1)
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        tableView.register(UINib(nibName: "CustomLeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomLeagueTableViewCell")
        
        if let sport = sport {
            presenter?.fetchLeagues(for: sport)
        }
        


    }
    
    
    func startLoading(){
        indicator.startAnimating()
    }
    
    func stopLoading(){
        indicator.stopAnimating()
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
            cell.setOutlets(league, sport: sport!)
        }
    

        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
}


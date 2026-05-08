//
//  FavoruiteTableViewController.swift
//  SportApp
//
//  Created by AndrewMagdy on 07/05/2026.
//

import UIKit

class FavoruiteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    

   
}

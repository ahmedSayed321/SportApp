//
//  CustomLeagueTableViewCell.swift
//  SportApp
//
//  Created by Me3bed on 04/05/2026.
//

import UIKit
import SDWebImage
class CustomLeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    
    
    @IBOutlet weak var leagueCountry: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func favBtn(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    func setOutlets(_ league : League){
        
        leagueName.text = league.leagueName ?? ""
        leagueCountry.text = league.countryName ?? ""
        
        if let logoString = league.leagueLogo, let url = URL(string: logoString) {
                leagueImage.sd_setImage(with: url, placeholderImage: UIImage(named: "tennis"))
            }
    }
    
}

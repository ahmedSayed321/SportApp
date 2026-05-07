//
//  EventCollectionViewCell.swift
//  SportApp
//
//  Created by AndrewMagdy on 04/05/2026.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var secondTeam: UIImageView!
    
    
    @IBOutlet weak var firstTeam: UIImageView!
    
    
    @IBOutlet weak var firstTeamName: UILabel!
    
    @IBOutlet weak var secondTeamName: UILabel!
    
    @IBOutlet weak var stadium: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var matchResult: UILabel!
    
    
    @IBOutlet weak var sportImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        layer.cornerRadius = 16
            layer.masksToBounds = false
            contentView.layer.cornerRadius = 16
            contentView.layer.masksToBounds = true
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.4
            layer.shadowOffset = CGSize(width: 0, height: 6)
            layer.shadowRadius = 10
    }
}


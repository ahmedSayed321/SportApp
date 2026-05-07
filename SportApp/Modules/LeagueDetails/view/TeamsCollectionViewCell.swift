//
//  TeamsCollectionViewCell.swift
//  SportApp
//
//  Created by AndrewMagdy on 05/05/2026.
//

import UIKit
import SDWebImage
class TeamsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var teamImg: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    override  func awakeFromNib() {
        setupUI()
    }
    private func setupUI() {
           backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 55/255, alpha: 1)
           layer.cornerRadius = 20
           layer.masksToBounds = false
           
           layer.shadowColor = UIColor(red: 100/255, green: 220/255, blue: 150/255, alpha: 0.3).cgColor
           layer.shadowOpacity = 1
           layer.shadowOffset = CGSize(width: 0, height: 6)
           layer.shadowRadius = 12
           
           contentView.layer.cornerRadius = 20
           contentView.layer.masksToBounds = true
           
           teamImg.layer.cornerRadius = teamImg.bounds.width / 2
           teamImg.layer.masksToBounds = true
           teamImg.contentMode = .scaleAspectFit
           teamImg.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 40/255, alpha: 1)
           teamImg.layer.borderWidth = 2.5
           teamImg.layer.borderColor = UIColor(red: 100/255, green: 220/255, blue: 150/255, alpha: 0.6).cgColor
           
           let gradient = CAGradientLayer()
           gradient.frame = contentView.bounds
           gradient.colors = [
               UIColor(red: 20/255, green: 20/255, blue: 50/255, alpha: 0.0).cgColor,
               UIColor(red: 10/255, green: 10/255, blue: 30/255, alpha: 1.0).cgColor
           ]
           gradient.locations = [0.4, 1.0]
           gradient.name = "gradientLayer"
           contentView.layer.insertSublayer(gradient, at: 0)
           
           teamName.textColor = .white
           teamName.font = UIFont.boldSystemFont(ofSize: 14)
           teamName.textAlignment = .center
           teamName.numberOfLines = 2
           //teamName.adjustsFontSizeToFit = true
           teamName.minimumScaleFactor = 0.7
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           
           if let gradient = contentView.layer.sublayers?.first(where: { $0.name == "gradientLayer" }) as? CAGradientLayer {
               gradient.frame = contentView.bounds
           }
           
           teamImg.layer.cornerRadius = min(teamImg.bounds.width, teamImg.bounds.height) / 2
           
           layer.shadowPath = UIBezierPath(
               roundedRect: bounds,
               cornerRadius: 20
           ).cgPath
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesBegan(touches, with: event)
           UIView.animate(withDuration: 0.1) {
               self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
           }
       }
       
       override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesEnded(touches, with: event)
           UIView.animate(withDuration: 0.1) {
               self.transform = .identity
           }
       }
       
       override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesCancelled(touches, with: event)
           UIView.animate(withDuration: 0.1) {
               self.transform = .identity
           }
       }
}

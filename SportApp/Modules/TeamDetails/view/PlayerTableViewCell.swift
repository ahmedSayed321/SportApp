//
//  PlayerTableViewCell.swift
//  SportApp
//
//  Created by Me3bed on 06/05/2026.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerLogo: UIImageView!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerAge: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Inset the card like CustomLeagueTableViewCell
        contentView.frame = bounds.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = false

        // Ensure perfect circle based on actual rendered size
        playerLogo.layer.cornerRadius = playerLogo.bounds.width / 2
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        // Dark card background
//        contentView.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = false

        // Green glow shadow (same as league cells)
        contentView.layer.shadowColor = UIColor.systemGreen.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 5
        contentView.layer.masksToBounds = false

        //playerName.textColor = .white
        //playerAge.textColor = .white
        
        // Circular player image — exact radius set in layoutSubviews
        playerLogo.clipsToBounds = true
        playerLogo.layer.cornerRadius = 20   // 40pt image → radius 20; refined in layoutSubviews
        playerLogo.backgroundColor = UIColor(red: 0.17, green: 0.19, blue: 0.28, alpha: 1)
        playerLogo.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setOutlets(_ player: Player) {
        playerName.text = player.playerName ?? "Unknown"
        playerAge.text = "Age: \(player.playerAge ?? "Unkown")"
        playerPosition.text = player.playerType ?? "Unknown"
        playerNumber.text = player.playerNumber ?? "0"
        if let logoString = player.playerImage, let url = URL(string: logoString) {
            playerLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "person"))
        }
    }
}

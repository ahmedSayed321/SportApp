import UIKit
import SDWebImage

class CustomLeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueCountry: UILabel!
    @IBOutlet weak var leagueName: UILabel!

    @IBOutlet weak var favButton: UIButton!
    private var isFavourite = false
    /// Called by the VC on every dequeue to stamp the correct state onto a recycled cell.
    func setFavouriteState(_ isFav: Bool) {
        isFavourite = isFav
        let imageName = isFav ? "star.fill" : "star"
        favButton.setImage(UIImage(systemName: imageName), for: .normal)
        favButton.tintColor = isFav ? .systemGreen : .whiteText
    }

    var isFavBtnClickedAtIndex: ((_ currentlyFav: Bool) -> Void)?

    @IBAction func favBtn(_ sender: Any) {
        // Toggle local state immediately for snappy UI feedback
        isFavourite.toggle()
        // Animate the new state
        if isFavourite {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            UIView.animate(withDuration: 0.1, animations: {
                self.favButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.favButton.tintColor = .systemGreen
            }) { _ in
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8) {
                    self.favButton.transform = .identity
                }
            }
        } else {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            UIView.animate(withDuration: 0.1, animations: {
                self.favButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.favButton.tintColor = .whiteText
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    self.favButton.transform = .identity
                }
            }
        }
        // Notify the VC whether the league is NOW a favourite (after toggle)
        isFavBtnClickedAtIndex?(isFavourite)
    }

   

    func setOutlets(_ league: League, sport: SportType) {
        leagueName.text = league.leagueName
        leagueCountry.text = league.countryName?.uppercased() ?? ""

        let placeholder: UIImage?
        switch sport {
        case .football:   placeholder = UIImage(named: "ball2")
        case .tennis:     placeholder = UIImage(named: "TennisBall")
        case .basketball: placeholder = UIImage(named: "basketballimage")
        case .cricket:    placeholder = UIImage(named: "cricketBall")
        }

        if let logoString = league.leagueLogo, let url = URL(string: logoString) {
            leagueImage.sd_setImage(with: url, placeholderImage: placeholder)
        } else {
            leagueImage.image = placeholder
        }
    }
}



extension CustomLeagueTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = false
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

//        contentView.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = false
        
        contentView.layer.shadowColor = UIColor.systemGreen.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 5
        contentView.layer.masksToBounds = false

        leagueImage.clipsToBounds = true
        leagueImage.layer.cornerRadius = 30
        leagueImage.backgroundColor = UIColor(red: 0.17, green: 0.19, blue: 0.28, alpha: 1)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

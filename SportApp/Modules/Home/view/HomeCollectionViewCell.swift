
import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    
    private let overlayView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: contentView.topAnchor),
            img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        contentView.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        sportName.removeFromSuperview()
        contentView.addSubview(sportName)
        contentView.bringSubviewToFront(sportName)
        
        sportName.translatesAutoresizingMaskIntoConstraints = false
        sportName.textColor = .white
        sportName.font = UIFont.boldSystemFont(ofSize: 16)
        sportName.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            sportName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            sportName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            sportName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        func addElevationShadow() {
            layer.shadowColor = UIColor.white.cgColor
            layer.shadowOpacity = 0.6
            layer.shadowOffset = CGSize(width: 0, height: 4)
            layer.shadowRadius = 8
            layer.masksToBounds = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 10
    }
    
    func setCornerRadius(for sport: SportType) {
        switch sport {
        case .football:
            roundCorners(topLeft: 20, topRight: 20, bottomLeft: 20, bottomRight: 0)
        case .basketball:
            roundCorners(topLeft: 20, topRight: 20, bottomLeft: 0, bottomRight: 20)
        case .cricket:
            roundCorners(topLeft: 20, topRight: 0, bottomLeft: 20, bottomRight: 20)
        case .tennis:
            roundCorners(topLeft: 0, topRight: 20, bottomLeft: 20, bottomRight: 20)
        }
    }
    
    private func roundCorners(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let path = UIBezierPath(
            shouldRoundRect: bounds,
            topLeftRadius: topLeft,
            topRightRadius: topRight,
            bottomLeftRadius: bottomLeft,
            bottomRightRadius: bottomRight
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        contentView.layer.mask = mask
        contentView.layer.cornerRadius = 0
        
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 10
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat) {
        self.init()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius), radius: topRightRadius, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        path.addArc(center: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius), radius: bottomRightRadius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius), radius: bottomLeftRadius, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        path.addArc(center: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius), radius: topLeftRadius, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: false)
        path.closeSubpath()
        cgPath = path
    }
}

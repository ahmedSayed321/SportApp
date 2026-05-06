//
//  LeagueDetailsViewController.swift
//  SportApp
//
//  Created by Me3bed on 05/05/2026.
//

import UIKit
import SDWebImage

class LeagueDetailsViewController: UIViewController {
  
    
    let indicator = UIActivityIndicatorView(style: .large)
    var leagueEventPresenter:LeagueDetailsProtocol?
    var leagueId: Int?
    var sportType: SportType?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 46/255, alpha: 1)
        collectionView.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 46/255, alpha: 1)
        indicator.center = view.center
        indicator.color = .white
        view.addSubview(indicator)
        leagueEventPresenter = LeagueDetailsPresenter(view: self)
        if let id = leagueId, let sport = sportType {
                   leagueEventPresenter?.fetchLeagueEvents(
                    sport: sport,
                       leagueId: id,
                       from: "2026-05-06",
                       to: "2026-07-05",
                       timeZone: "Africa/Cairo",
                       eventType: .upComing
                   )
            leagueEventPresenter?.fetchLeagueEvents(
             sport: sport,
                leagueId: id,
                from: "2026-01-06",
                to: "2026-02-12",
                timeZone: "Africa/Cairo",
                eventType: .latest
            )
            leagueEventPresenter?.fetchTeams(leagueId: id, sport: sport, eventType: .teams)
            self.title=sport.displayName
           
               }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "EventMatchCustomCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(
            UINib(nibName: "TeamsCustomCell", bundle: nil),
            forCellWithReuseIdentifier: "teamsCell"
        )
        
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
            
            
            let layout = UICollectionViewCompositionalLayout { index, environment in
                if index == 0 {
                    return self.setupSection()
                } else if index == 1 {
                    return self.setupSection2()
                } else {
                    return self.setupSection3()
                }
            }
            collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 46/255, alpha: 1)
        
        // ✅ Custom Font + Color + Shadow
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1),
            .font: UIFont.boldSystemFont(ofSize: 22),
            .shadow: {
                let shadow = NSShadow()
                shadow.shadowColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 0.8)
                shadow.shadowBlurRadius = 10
                return shadow
            }()
        ]
        
        // ✅ Back button اخضر
        navigationController?.navigationBar.tintColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
        
        // ✅ خط تحت الـ navbar شفاف
        appearance.shadowColor = .clear
        
        // ✅ Bottom border بلون اخضر
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 0.4)
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    

   

}

extension LeagueDetailsViewController : LeagueEventsViewProtocol{
    func didFetchLeaguesEvents() {
        DispatchQueue.main.async {
               self.collectionView.reloadData() 
           }
    }
    
    func didFailWithError(_ error: String) {
    

    }

    func showLoading() {
        indicator.startAnimating()
    }
    
    func hideLoading() {
        indicator.stopAnimating()

    }
}
extension LeagueDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier,
            for: indexPath) as! SectionHeaderView
        
        switch indexPath.section {
        case 0: header.configure(title: "Upcoming Events")
        case 1: header.configure(title: "Latest Events")
        case 2: header.configure(title: "Teams")
        default: break
        }
        
        return header
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return leagueEventPresenter?.getLeaguesCount() ?? 0
        case 1:
            return leagueEventPresenter?.getLatestEventCount() ?? 0
        case 2:
            return leagueEventPresenter?.getTeamsCount() ?? 0
        default :
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EventCollectionViewCell
            if let event = leagueEventPresenter?.getLeague(at: indexPath.row) {
                configureEventCell(cell, with: event, showResult: false)
            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EventCollectionViewCell
            if let event = leagueEventPresenter?.getLatestLeague(at: indexPath.row) {
                configureEventCell(cell, with: event, showResult: true)
            }
            return cell
            
        case 2:
            let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            if let team = leagueEventPresenter?.getTeam(at: indexPath.row) {
                teamCell.teamName.text = team.teamName ?? "Unknown"
                if let logoString = team.teamLogo, let logoUrl = URL(string: logoString) {
                    teamCell.teamImg.sd_setImage(with: logoUrl, placeholderImage: UIImage(named: "teamplace"))
                } else {
                    teamCell.teamImg.image = UIImage(named: "teamplace")
                }
            }
            return teamCell
            
        default:
            return UICollectionViewCell()
        }
    }

    
    
    
    
}
extension LeagueDetailsViewController{
    private func configureEventCell(_ cell: EventCollectionViewCell, with event: LeagueEvent, showResult: Bool) {
        if let homeLogoString = event.homeTeamLogo, let homeUrl = URL(string: homeLogoString) {
            cell.firstTeam.sd_setImage(with: homeUrl, placeholderImage: UIImage(named: "teamplace"))
        } else {
            cell.firstTeam.image = UIImage(named: "teamplace")
        }
        
        if let awayLogoString = event.awayTeamLogo, let awayUrl = URL(string: awayLogoString) {
            cell.secondTeam.sd_setImage(with: awayUrl, placeholderImage: UIImage(named: "teamplace"))
        } else {
            cell.secondTeam.image = UIImage(named: "teamplace")
        }
        
        cell.firstTeamName.text = event.eventHomeTeam ?? "Unknown"
        cell.secondTeamName.text = event.eventAwayTeam ?? "Unknown"
        cell.stadium.text = event.leagueName ?? "Unknown"
        cell.matchDate.text = event.eventDate ?? "Unknown"
        
        if let sport = sportType {
            switch sport {
            case .football:
                cell.sportImg.image = UIImage(named: "footbk")
            case .basketball:
                cell.sportImg.image = UIImage(named: "basketball")
            case .cricket:
                cell.sportImg.image = UIImage(named: "Cricket")
            case .tennis:
                cell.sportImg.image = UIImage(named: "tennis")
            }
        }
        if showResult {
            cell.matchResult.text = event.eventFinalResult ?? "Unknown"
        }else{
            cell.matchResult.text="VS"
        }
    }
}
extension LeagueDetailsViewController{
    
    func setupSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .absolute(253)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 0)
        section.interGroupSpacing = 12

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        section.visibleItemsInvalidationHandler = { items, offset, environment in
                let containerWidth = environment.container.contentSize.width
                items.forEach { item in
                    guard item.representedElementCategory == .cell else { return }
                    let itemCenterX = item.frame.midX - offset.x
                    let distanceFromCenter = abs(itemCenterX - containerWidth / 2)
                    let percentage = min(distanceFromCenter / containerWidth, 1)
                    let scale = 1.0 - (0.15 * percentage)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                    item.alpha = 1.0 - (0.3 * percentage)
                }
            }

        return section
    }
    
    func setupSection2() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(253
                                      )
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 12
        
        return section
    }
    func setupSection3() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.40),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 0)
        section.interGroupSpacing = 12

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            let containerWidth = environment.container.contentSize.width
            items.forEach { item in
                guard item.representedElementCategory == .cell else { return }
                let itemCenterX = item.frame.midX - offset.x
                let distanceFromCenter = abs(itemCenterX - containerWidth / 2)
                let percentage = min(distanceFromCenter / containerWidth, 1)
                
                let scale = 1.0 - (0.2 * percentage)
                
                let rotation = 0.08 * percentage * (itemCenterX < containerWidth / 2 ? -1 : 1)
                
                let translationY = 20 * percentage
                
                var transform = CATransform3DIdentity
                transform = CATransform3DScale(transform, scale, scale, 1)
                transform = CATransform3DRotate(transform, rotation, 0, 0, 1)
                transform = CATransform3DTranslate(transform, 0, translationY, 0)
                
                item.transform3D = transform
                item.alpha = 1.0 - (0.4 * percentage)
            }
        }

        return section
    }
}
// MARK: - Section Header View
class SectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "SectionHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1) // Light Green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}


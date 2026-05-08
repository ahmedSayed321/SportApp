

import UIKit
import CoreData

protocol HomeViewProtocol: AnyObject {}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: HomePresenterProtocol!
    var sports: [SportType] = []
    var appdel:AppDelegate!
    var localDataSource:LocalDataSoucreProtocol!
    var appCxt:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appdel=UIApplication.shared.delegate as? AppDelegate
        self.appCxt=self.appdel.persistentContainer.viewContext
        localDataSource=LocalDataSource(cxt: appCxt)
        setupNavigationBar()
        setupHeaderLabel()
        presenter = HomePresenter(view: self)
        sports = presenter.getSports()
        view.backgroundColor = .appPrimaryBackground
        collectionView.backgroundColor = .clear
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(nib, forCellWithReuseIdentifier: "teamAndHomeCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let spacing: CGFloat = 15
        let cellWidth = (collectionView.bounds.width - (spacing * 3)) / 2
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.3)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 20, left: spacing, bottom: 20, right: spacing)
    }
    
    
    
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamAndHomeCell", for: indexPath) as! HomeCollectionViewCell
        let sport = sports[indexPath.item]
        cell.sportName.text = sport.displayName
        cell.img.image = UIImage(named: sport.imageName)
        cell.setCornerRadius(for: sport)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = sports[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let leagueVC = storyboard.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
            
            leagueVC.sport = sport
            leagueVC.presenter = LeaguesPresenter(view: leagueVC,localDataSource: localDataSource)
            
            navigationController?.pushViewController(leagueVC, animated: true)
        print("Selected: \(sport.displayName)")
    }
    
    
    
}
extension HomeViewController{
    
    private func setupNavigationBar() {
        let green = UIColor(red: 0/255, green: 200/255, blue: 83/255, alpha: 1)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appPrimaryBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance  

        let titleLabel = UILabel()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: green,
            .kern: -1.0
        ]
        titleLabel.attributedText = NSAttributedString(string: "Remontada", attributes: attributes)
        titleLabel.font = UIFont.italicSystemFont(ofSize: 22)
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let symbolImage = UIImage(systemName: "soccerball", withConfiguration: symbolConfig)
        let symbolView = UIImageView(image: symbolImage)
        symbolView.tintColor = green
        
        let stackView = UIStackView(arrangedSubviews: [symbolView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        
        self.tabBarController?.title = nil
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
    }
    private func setupHeaderLabel() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Choose Your Sport"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .whiteText
        
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Live coverage, stats, and real-time news"
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        subtitleLabel.textColor = .whiteText
        subtitleLabel.numberOfLines = 2
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

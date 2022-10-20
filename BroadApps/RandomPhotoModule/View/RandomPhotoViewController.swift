import UIKit
import Kingfisher

class RandomPhotoViewController: UIViewController {
    
    var presenter: RandomPhotoPresenterProtocol!
    private var timer: Timer?
    
    private let randomPhotoSearchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.barStyle = .black
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.layer.cornerRadius = 10
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return searchBar
    }()
    
    private var randomPhotoCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.register(RandomPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RandomPhotoCollectionViewCell.identifier)
        return colletionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(navigationController)
        view.backgroundColor = .white
        addViews()
        addConstraints()
        createLayout()
    }
    //MARK: - addView(delegate/view property)
    
    private func addViews() {
        view.addSubviews(randomPhotoSearchBar, randomPhotoCollectionView)
        randomPhotoCollectionView.delegate = self
        randomPhotoCollectionView.dataSource = self
        randomPhotoSearchBar.delegate = self
    }
    //MARK: - Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            randomPhotoSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            randomPhotoSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomPhotoSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            randomPhotoCollectionView.topAnchor.constraint(equalTo: randomPhotoSearchBar.bottomAnchor, constant: 10),
            randomPhotoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            randomPhotoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            randomPhotoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    //MARK: - Сreate collectionViewFlowLayout
    
    private func createLayout() {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 2.0),
            heightDimension: .fractionalHeight(1.0 / 1.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth( 1.0 / 2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        randomPhotoCollectionView.collectionViewLayout = layout
    }
}

extension RandomPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photosResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = randomPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: RandomPhotoCollectionViewCell.identifier,
                                                                 for: indexPath) as! RandomPhotoCollectionViewCell
        if let imageURL = presenter.photosResult?[indexPath.row].urls.small{
            cell.randomPhotoImageView.kf.setImage(with: URL(string: imageURL))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = presenter.photosResult?[indexPath.row]
        presenter.tapOnThePhoto(navigationConroller: navigationController!, photo: photo)
    }
}

extension RandomPhotoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [self] _ in
            presenter.getSearchPhoto(query: searchText)
            randomPhotoCollectionView.reloadData()
        })
    }
}

extension RandomPhotoViewController: RandomPhotoViewProtocol {
    func sucess() {
        randomPhotoCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        
    }
}

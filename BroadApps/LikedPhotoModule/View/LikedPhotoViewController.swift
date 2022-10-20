import UIKit
import RealmSwift
import Kingfisher

final class LikedPhotoViewController: UIViewController {
    
    //MARK: - Property
    
    var presenter: LikedPhotoPresenterProtocol!
    var favoritsPhotos: Results<PhotosModel>?
    
    private let likedTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LikedTableViewCell.self, forCellReuseIdentifier: LikedTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
        likedTableView.reloadData()
    }
    
    //MARK: - Add subviews/view property method
    
    private func addViews(){
        view.backgroundColor = .white
        title = "Favorits Photo"
        view.addSubviews(likedTableView)
        likedTableView.delegate = self
        likedTableView.dataSource = self
    }
    
    //MARK: - Add Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            likedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            likedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            likedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            likedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Implementation tableview

extension LikedPhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Number of cells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritsPhotos?.count ?? 0
    }
    
    //MARK: - Cells implementation
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = likedTableView.dequeueReusableCell(withIdentifier: LikedTableViewCell.identifier, for: indexPath) as! LikedTableViewCell
        cell.likedLabel.text = favoritsPhotos?[indexPath.row].autorName
        cell.likedImageView.kf.setImage(with: URL(string: (favoritsPhotos?[indexPath.row].imageURL)!))
        return cell
    }
    
    //MARK: - Set height
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5
    }
    
    //MARK: - Implementation of cell deletion
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteModel(model: favoritsPhotos![indexPath.row])
            likedTableView.reloadData()
        }
    }
}

//MARK: - Set photos

extension LikedPhotoViewController: LikedPhotoViewProtocol {
    func setPhoto(photo: RealmSwift.Results<PhotosModel>?) {
        favoritsPhotos = photo
    }
}

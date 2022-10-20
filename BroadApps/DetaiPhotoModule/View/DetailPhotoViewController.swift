import UIKit
import Kingfisher

final class DetailPhotoViewController: UIViewController {
    
    //MARK: - Property
    
    var presenter: DetailPhotoPresenterProtocol!
    var photoModel = PhotosModel()

    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let detailAutorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let detailCreateDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let detailLocationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let detailDownloadLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var likeBarItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.image = UIImage(named: "heart")
        barButtonItem.style = .plain
        barButtonItem.action = #selector(liked(sender:))
        return barButtonItem
    }()
    
    //MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
        presenter.setPhoto()
    }
    
    //MARK: - Add subviews/view property method

    private func addViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = likeBarItem
        likeBarItem.target = self
        view.addSubviews(detailImageView, detailAutorLabel, detailCreateDateLabel, detailLocationLabel, detailDownloadLabel)
    }
    
    //MARK: - Add Constraints

    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            
            detailAutorLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 10),
            detailAutorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailAutorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            detailCreateDateLabel.topAnchor.constraint(equalTo: detailAutorLabel.bottomAnchor, constant: 10),
            detailCreateDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailCreateDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            detailLocationLabel.topAnchor.constraint(equalTo: detailCreateDateLabel.bottomAnchor, constant: 10),
            detailLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            
            detailDownloadLabel.topAnchor.constraint(equalTo: detailLocationLabel.bottomAnchor, constant: 10),
            detailDownloadLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailDownloadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    //MARK: - @objc methods

    @objc func liked(sender: Any) {
        likeBarItem.image = UIImage(named: "blackHeart")
        presenter.saveModel(model: photoModel)
    }
}

//MARK: - Set info method

extension DetailPhotoViewController: DetailPhotoViewProtocol {
    
    func setInfoFromPastViewController(info: UnsplashPhoto?) {
        
        let comingPhotoModel = PhotosModel()
        guard let photo = info else { return}
        detailCreateDateLabel.text = "Дата создания: " + (photo.created_at)
        detailDownloadLabel.text = "Количество скачиваний: " + "\(photo.downloads)"
        
        if let locationName = photo.location?.name {
            detailLocationLabel.text = "Местоположение: " + locationName
        }
        if let userName = photo.user?.name {
            detailAutorLabel.text = "Имя автора: " + userName
            comingPhotoModel.autorName = userName
        }
        if let photoURL = photo.urls.small {
            detailImageView.kf.setImage(with: URL(string: photoURL))
            comingPhotoModel.imageURL = photoURL
        }
        photoModel = comingPhotoModel
    }
}

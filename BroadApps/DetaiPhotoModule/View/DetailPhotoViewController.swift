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
    
    func setPhoto(photo: UnsplashPhoto?) {
        detailImageView.kf.setImage(with: URL(string: photo?.urls.small ?? ""))
        detailAutorLabel.text = "Имя автора: " + (photo?.user?.name ?? "")
        detailCreateDateLabel.text = "Дата создания: " + (photo?.created_at ?? "")
        if photo?.location?.name != nil {
            detailLocationLabel.text = "Местоположение: " + (photo?.location?.name)!
        }
        detailDownloadLabel.text = "Количество скачиваний: " + "\(photo!.downloads)"
        let comingPhotoModel = PhotosModel()
        comingPhotoModel.autorName = photo?.user?.name ?? ""
        comingPhotoModel.imageURL = photo?.urls.small ?? ""
        photoModel = comingPhotoModel
    }
}

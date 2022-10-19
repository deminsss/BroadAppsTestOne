import UIKit
import Kingfisher

class DetailPhotoViewController: UIViewController {
    
    var presenter: DetailPhotoPresenterProtocol! 

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
        presenter.setPhoto()
    }
    private func addViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        view.addSubviews(detailImageView, detailAutorLabel, detailCreateDateLabel, detailLocationLabel, detailDownloadLabel)
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.5),
            
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
}

extension DetailPhotoViewController: DetailPhotoViewProtocol {
    func setPhoto(photo: UnsplashPhoto?) {
        detailImageView.kf.setImage(with: URL(string: photo?.urls.small ?? ""))
        detailAutorLabel.text = "Имя автора: " + (photo?.user?.name ?? "")
        detailCreateDateLabel.text = "Дата создания: " + (photo?.created_at ?? "")
        if photo?.location?.name != nil {
            detailLocationLabel.text = "Местоположение: " + (photo?.location?.name)!
        }
        detailDownloadLabel.text = "Количество скачиваний: " + "\(photo!.downloads)"
    }
}

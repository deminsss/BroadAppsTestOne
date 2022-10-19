import UIKit

class RandomPhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    //MARK: - Property
    
    var randomPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var randomPhotoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(randomPhotoImageView, randomPhotoLabel)
    }
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Constraints
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            randomPhotoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            randomPhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            randomPhotoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            randomPhotoImageView.heightAnchor.constraint(equalToConstant: self.frame.height),

            randomPhotoLabel.topAnchor.constraint(equalTo: randomPhotoImageView.bottomAnchor, constant: 10),
            randomPhotoLabel.centerXAnchor.constraint(equalTo: randomPhotoImageView.centerXAnchor)
        ])
    }
}

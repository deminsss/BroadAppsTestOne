import UIKit

final class LikedTableViewCell: UITableViewCell {
    
    //MARK: - Property
    
    static let identifier = "Cell"
    
    var likedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var likedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(likedImageView, likedLabel)
    }
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    //MARK: - Add Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            likedImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            likedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            likedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            likedImageView.widthAnchor.constraint(equalToConstant: self.frame.width / 5),
            
            likedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            likedLabel.leadingAnchor.constraint(equalTo: likedImageView.trailingAnchor, constant: 20),
            likedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            likedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

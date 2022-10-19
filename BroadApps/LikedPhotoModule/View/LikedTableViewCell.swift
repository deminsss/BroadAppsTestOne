import UIKit

final class LikedTableViewCell: UITableViewCell {
    
    //MARK: - Variables
    static let identifier = "Cell"
    
    //MARK: - Property
    
    private let likedImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let likedLabel: UILabel = {
        let label = UILabel()
        label.text = "aaa"
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
    
    
    
    //MARK: - Constraints
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            likedImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            likedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            likedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20),
            
            likedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

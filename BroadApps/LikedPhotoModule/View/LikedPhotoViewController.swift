import UIKit

class LikedPhotoViewController: UIViewController {
    
    var presenter: LikedPhotoPresenterProtocol!
    
    private let likedTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LikedTableViewCell.self, forCellReuseIdentifier: LikedTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
    }
    
    private func addViews(){
        view.backgroundColor = .white
        view.addSubviews(likedTableView)
        likedTableView.delegate = self
        likedTableView.dataSource = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            likedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            likedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            likedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            likedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension LikedPhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likedTableView.dequeueReusableCell(withIdentifier: LikedTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    
}

extension LikedPhotoViewController: LikedPhotoViewProtocol {
    
}

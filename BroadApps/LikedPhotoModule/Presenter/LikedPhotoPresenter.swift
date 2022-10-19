import Foundation

protocol LikedPhotoViewProtocol: AnyObject {
    
}

protocol LikedPhotoPresenterProtocol: AnyObject {
    init(view: LikedPhotoViewProtocol)
}

class LikedPhotoPresenter: LikedPhotoPresenterProtocol {

    weak var view: LikedPhotoViewProtocol?
    
    required init(view: LikedPhotoViewProtocol) {
        self.view = view
    }
}

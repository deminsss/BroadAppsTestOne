import Foundation

protocol DetailPhotoViewProtocol: AnyObject {
    func setPhoto(photo: UnsplashPhoto?)
}

protocol DetailPhotoPresenterProtocol {
    init(view: DetailPhotoViewProtocol, photo: UnsplashPhoto?)
    func setPhoto()
}

class DetailPhotoPresenter: DetailPhotoPresenterProtocol {
    
    weak var view: DetailPhotoViewProtocol?
    var photo: UnsplashPhoto?
    
    required init(view: DetailPhotoViewProtocol, photo: UnsplashPhoto?) {
        self.view = view
        self.photo = photo
    }
    
    func setPhoto() {
        self.view?.setPhoto(photo: photo)
    }
}

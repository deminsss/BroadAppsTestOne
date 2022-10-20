import Foundation

//MARK: - View protocol

protocol DetailPhotoViewProtocol: AnyObject {
    func setPhoto(photo: UnsplashPhoto?)
}

//MARK: - Presenter protocol

protocol DetailPhotoPresenterProtocol {
    init(view: DetailPhotoViewProtocol, photo: UnsplashPhoto?, realm: RealmManagerProtocol)
    func setPhoto()
    func saveModel(model: PhotosModel)
}

final class DetailPhotoPresenter: DetailPhotoPresenterProtocol {
    
    //MARK: - Presenter property

    weak var view: DetailPhotoViewProtocol?
    var photo: UnsplashPhoto?
    var realm: RealmManagerProtocol?
    
    //MARK: - Presenter init

    required init(view: DetailPhotoViewProtocol, photo: UnsplashPhoto?, realm: RealmManagerProtocol) {
        self.view = view
        self.photo = photo
        self.realm = realm
    }
    
    //MARK: - Set photo method

    func setPhoto() {
        self.view?.setPhoto(photo: photo)
    }
    
    //MARK: - Save photo method

    func saveModel(model: PhotosModel) {
        self.realm?.savePhotosModel(model: model)
    }
}

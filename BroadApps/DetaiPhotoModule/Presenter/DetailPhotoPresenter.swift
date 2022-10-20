import Foundation

//MARK: - View protocol

protocol DetailPhotoViewProtocol: AnyObject {
    func setInfoFromPastViewController(info: UnsplashPhoto?)
}

//MARK: - Presenter protocol

protocol DetailPhotoPresenterProtocol {
    init(view: DetailPhotoViewProtocol, info: UnsplashPhoto?, realm: RealmManagerProtocol)
    func setPhoto()
    func saveModel(model: PhotosModel)
}

final class DetailPhotoPresenter: DetailPhotoPresenterProtocol {
    
    //MARK: - Presenter property

    weak var view: DetailPhotoViewProtocol?
    var info: UnsplashPhoto?
    var realm: RealmManagerProtocol?
    
    //MARK: - Presenter init

    required init(view: DetailPhotoViewProtocol, info: UnsplashPhoto?, realm: RealmManagerProtocol) {
        self.view = view
        self.info = info
        self.realm = realm
    }
    
    //MARK: - Set photo method

    func setPhoto() {
        self.view?.setInfoFromPastViewController(info: info)
    }
    
    //MARK: - Save photo method

    func saveModel(model: PhotosModel) {
        self.realm?.savePhotosModel(model: model)
    }
}

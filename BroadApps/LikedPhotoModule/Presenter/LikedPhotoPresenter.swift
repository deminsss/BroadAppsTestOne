import Foundation
import RealmSwift

//MARK: - View protocol

protocol LikedPhotoViewProtocol: AnyObject {
    func setPhoto(photo: Results<PhotosModel>?)
}

//MARK: - Presenter protocol

protocol LikedPhotoPresenterProtocol: AnyObject {
    init(view: LikedPhotoViewProtocol, realm: RealmManagerProtocol)
    func setPhoto()
    func deleteModel(model: PhotosModel)
}

final class LikedPhotoPresenter: LikedPhotoPresenterProtocol {
    
    //MARK: - Presenter property
    
    weak var view: LikedPhotoViewProtocol!
    var realm: RealmManagerProtocol
    
    //MARK: - Presenter init
    
    required init(view: LikedPhotoViewProtocol, realm: RealmManagerProtocol) {
        self.view = view
        self.realm = realm
        setPhoto()
    }
    
    //MARK: - Set photos to view method
    
    func setPhoto() {
        self.view.setPhoto(photo: realm.getPhotos())
    }
    
    //MARK: - Delete photo method
    
    func deleteModel(model: PhotosModel) {
        self.realm.deletePhotosModel(model: model)
    }
}

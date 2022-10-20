import Foundation
import RealmSwift
//MARK: - RealmManager protocol
protocol RealmManagerProtocol {
    func savePhotosModel(model: PhotosModel)
    func deletePhotosModel(model: PhotosModel)
    func getPhotos() -> Results<PhotosModel> 
}

final class RealmManager: RealmManagerProtocol {
    //MARK: - RealmManager property
    
    private let localRealm = try! Realm()
    
    //MARK: - Save model method
    
    func savePhotosModel(model: PhotosModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    //MARK: - Delete model method
    
    func deletePhotosModel(model: PhotosModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    //MARK: - Get model method
    
    func getPhotos() -> Results<PhotosModel> {
        let photos = localRealm.objects(PhotosModel.self)
        return photos
    }
}

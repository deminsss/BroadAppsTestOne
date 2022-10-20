import Foundation
import RealmSwift
import Foundation

final class PhotosModel: Object {
    //MARK: - Realm model property
    
    @Persisted var autorName: String
    @Persisted var imageURL: String


}

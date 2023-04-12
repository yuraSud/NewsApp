

import UIKit

class NewsUICollectionsView: UICollectionView {
    
    static let idCollectionCell = "idCellCollections"
    
    let newsLayout = UICollectionViewLayout()
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: newsLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



import UIKit

class NewsCollectionsView: UICollectionView {
    
    static let idCollectionCell = "idCellCollections"
    
    let newsLayout = UICollectionViewFlowLayout()
    var newsYUra: NewsYUra? = nil {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: newsLayout)
        
        setupViews()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        newsLayout.minimumLineSpacing = 15
        newsLayout.minimumInteritemSpacing = 5
        register(NewsCell.self, forCellWithReuseIdentifier: NewsCollectionsView.idCollectionCell)
    }
    
    private func setDelegates(){
        dataSource = self
    }
}

//MARK: - DataSource

extension NewsCollectionsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        newsYUra?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionsView.idCollectionCell, for: indexPath) as? NewsCell else { print(NewsError.errorReturnCell)
            return UICollectionViewCell()
        }
        if let newsYu = newsYUra {
            let article = newsYu.articles[indexPath.row]
            cell.news = NewsForCell(article: article)
        }
        return cell
    }
}


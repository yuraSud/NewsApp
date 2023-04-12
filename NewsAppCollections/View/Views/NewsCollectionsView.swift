

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
        backgroundColor = .gray
        translatesAutoresizingMaskIntoConstraints = false
        newsLayout.minimumLineSpacing = 15
        newsLayout.minimumInteritemSpacing = 5
        register(NewsCell.self, forCellWithReuseIdentifier: NewsCollectionsView.idCollectionCell)
    }
    
    private func setDelegates(){
        delegate = self
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
            //print(article.publishedAt, "index row = \(indexPath.row)", article.source.name, article.author ?? "niiil")
            
            cell.news = NewsForCell(article: article)
        }
        return cell
    }
}

//MARK: - Delegate

extension NewsCollectionsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = cellForItem(at: indexPath) as? NewsCell else {return}
        let news = cell.news?.article
        
        print(news?.publishedAt ?? "nil date", news?.author ?? "nil author")
               
    }
}

//MARK: - DelegateFloWLayout

extension NewsCollectionsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width * 9 / 16)
    }
}

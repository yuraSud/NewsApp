
import UIKit

class NewsViewController: UIViewController {

    private let collectionView = NewsCollectionsView()
    private let fetchManager = NetworkManagers.shared
    private let searchController = UISearchController()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        fetchData()
        configureSearchBar()
    }
    
    private func setupViews(){
        title = "Breaking News"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func fetchData(_ textSearch: String? = nil){
        fetchManager.fetchNewsFromServer(searchText: textSearch ?? "news") { result in
            switch result {
            case .success(let dataNews):
                self.collectionView.newsYUra = dataNews
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func configureSearchBar(){
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search"
    }
}

extension NewsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCell else {return}
        
        let vcDetail = DetailNewsViewController()
        vcDetail.newsForDetail = cell.news
        vcDetail.image = cell.image
        vcDetail.title = "\(cell.news?.article.source.name ?? "")"
        navigationController?.pushViewController(vcDetail, animated: true)
    }
}

//MARK: - DelegateFloWLayout

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width * 9 / 16)
    }
}

//MARK: - Search Controller Configuration

extension NewsViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.search(searchText)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text ?? "")
    }
    
    func search(_ query: String) {
        if query.count >= 1 {
            fetchData(query)
        } else{
            fetchData()
        }
        collectionView.reloadData()
    }
}


//MARK: - Set Constraints

extension NewsViewController {
   
    private func setConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}



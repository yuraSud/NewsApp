
import UIKit

class NewsViewController: UIViewController {

    private let collectionView = NewsCollectionsView()
    let fetchManager = NetworkManagers.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        fetchData()
    }
    
    private func setupViews(){
        title = "Breaking News"
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    func fetchData(){
        fetchManager.fetchNewsFromServer(searchText: "car") { result in
            switch result {
            case .success(let dataNews):
                self.collectionView.newsYUra = dataNews
            case .failure(let err):
                print(err)
            }
        }
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


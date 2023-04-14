
import UIKit

class NewsCell: UICollectionViewCell {
    
    var news: NewsForCell? {
        didSet {
            if news != nil {
                configureCell()
            }
        }
    }
    
    let fetchManager = NetworkManagers.shared
    let titleLabel = UILabel()
    let datePublishedLabel = UILabel()
    let authorLabel = UILabel()
    let imageViewNews = UIImageView()
    var stack = UIStackView()
    var image = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStack()
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .quaternaryLabel
        addSubview(titleLabel)
        addSubview(imageViewNews)
        layer.cornerRadius = 20
        titleLabel.numberOfLines = 2
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.shadowOffset = .init(width: 0.4, height: 0.3)
        titleLabel.shadowColor = .gray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageViewNews.translatesAutoresizingMaskIntoConstraints = false
        imageViewNews.contentMode = .scaleAspectFit
    }
    
    private func configureStack(){
        stack = UIStackView(arrangedSubviews: [datePublishedLabel,authorLabel])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
    }
    
    
    private func configureCell(){
        titleLabel.text = "\(news?.article.source.name ?? " ") ,  \(news?.article.title ?? " ")"
        authorLabel.text = news?.article.author ?? " "
        datePublishedLabel.text = news?.article.publishedAt ?? " "
        
        guard let imageURL = news?.article.urlToImage else {
            DispatchQueue.main.async {
                self.imageViewNews.image = UIImage(named: "no-pictures")
            }
            return}
        fetchManager.fetchImageToArticles(imageURL) { image in
            switch image {
            case .success(let img):
                DispatchQueue.main.async {
                    self.imageViewNews.image = img
                    self.image = img
                }
            case .failure(_):
                print(NewsError.errorDownloadImage)
                
            }
        }
    }
}

extension NewsCell{
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            imageViewNews.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageViewNews.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            imageViewNews.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 4/5),
            imageViewNews.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -10),
            
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
        ])
    }
}

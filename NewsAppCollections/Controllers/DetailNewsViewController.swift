
import UIKit

class DetailNewsViewController: UIViewController {

    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let imageView = UIImageView()
    var image = UIImage(named: "no-pictures")
    var stack = UIStackView()
    let dateLabel = UILabel()
    let authorLabel = UILabel()
    let linkLabel = UILabel()
    
    
    var newsForDetail: NewsForCell? = nil {
        didSet{
            guard newsForDetail != nil else {return}
            DispatchQueue.main.async {
                self.setDataToLabel()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupLink()
    }

    func setupView(){
        setupStack()

        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(stack)
        view.addSubview(detailLabel)
        view.addSubview(linkLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 4
        titleLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        detailLabel.font = .systemFont(ofSize: 17)
        dateLabel.textColor = .secondaryLabel
        authorLabel.textColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        linkLabel.textColor = .link
        titleLabel.font = .systemFont(ofSize: 19)
    }
   
    func setupStack(){
        stack = UIStackView(arrangedSubviews: [authorLabel,dateLabel])
        stack.axis = .horizontal
    }
    
    func setupLink(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToLink))
        linkLabel.addGestureRecognizer(tapGesture)
        linkLabel.isUserInteractionEnabled = true
    }
    
    @objc func tapToLink(){
        guard let urlToLink = linkLabel.text, let url = URL(string: urlToLink) else {return}
        UIApplication.shared.open(url)
    }

    func setDataToLabel(){
        let article = newsForDetail?.article
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        dateLabel.text = article?.publishedAt
        detailLabel.text = article?.description
        imageView.image = image == nil ? UIImage(named: "no-pictures") : image
        linkLabel.text = article?.url
    }
}

extension DetailNewsViewController {
    func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 8/16),

            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            stack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            detailLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 15),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            linkLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20),
            linkLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            linkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linkLabel.bottomAnchor.constraint(lessThanOrEqualTo:  view.bottomAnchor, constant: -20)
        ])
    }
}


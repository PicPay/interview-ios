import UIKit

final class ContactCell: UITableViewCell {
    private let contactImageSize: CGFloat = 100
    private var imageLoadingTask: URLSessionDataTask?
    
    lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadingTask?.cancel()
        fullnameLabel.text = ""
        contactImage.image = UIImage(systemName: "person")
    }
    
    func configureViews() {
        contentView.addSubview(contactImage)
        contentView.addSubview(fullnameLabel)
        
        NSLayoutConstraint.activate([
            contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contactImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: contactImageSize),
            contactImage.widthAnchor.constraint(equalToConstant: contactImageSize),
            
            fullnameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with contact: Contact) {
        fullnameLabel.text = contact.name
        
        guard let imageURL = URL(string: contact.photoURL) else { return }
        
        if let cachedImage = ImageCache.shared.image(for: imageURL) {
            contactImage.image = cachedImage
        } else {
            imageLoadingTask = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    print("Error converting data to image")
                    return
                }
                
                ImageCache.shared.cache(image: downloadedImage, for: imageURL)
                
                DispatchQueue.main.async {
                    self?.contactImage.image = downloadedImage
                }
            }
            imageLoadingTask?.resume()
        }
    }
}

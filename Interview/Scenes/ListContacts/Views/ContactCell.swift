import UIKit.UITableViewCell
import UIKit.UIImageView

final class ContactCell: UITableViewCell, ViewCode {
    
    // MARK: - Layout components
    
    private lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewCode()
    }
    
    // MARK: - Lyfecicle
    
    override func prepareForReuse() {
        contactImage.image = nil
        fullnameLabel.text = String()
    }
    
    // MARK: - Internal methods
    
    public func setupCell(_ contact: ListContactViewData.Contact) {
        loadPhoto(contact.imageURL)
        fullnameLabel.text = contact.name
        applyViewCode()
    }
    
    // MARK: - ViewCode conforms
    
    func setupHierarchy() {
        contentView.addSubview(contactImage)
        contentView.addSubview(fullnameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contactImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: 100),
            contactImage.widthAnchor.constraint(equalToConstant: 100),
            fullnameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Private methods
    
    private func loadPhoto(_ url: String) {
        guard let urlPhoto = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlPhoto) { [weak self] data, _, _ in
            guard let data else { return }
            self?.handlePhoto(data)
        }
        .resume()
    }
    
    private func handlePhoto(_ data: Data) {
        DispatchQueue.main.async {
            self.contactImage.image = UIImage(data: data)
        }
    }
}

import UIKit

class ContactCell: UITableViewCell {
    lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = .lightGray
        return imgView
    }()
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private var imageLoadTask: Task<Void, Never>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureViews()
    }
    
    func configureViews() {
        self.setupViewHierarchy()
        self.setupConstraints()
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(contactImage)
        contentView.addSubview(fullnameLabel)
    }
    
    private func setupConstraints() {
        contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        contactImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contactImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contactImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        fullnameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16).isActive = true
        fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setupCell(with contact: Contact) {
        self.fullnameLabel.text = contact.name
        self.contactImage.image = nil
        self.contactImage.backgroundColor = .lightGray

        guard let url = URL(string: contact.photoURL) else {
            self.contactImage.backgroundColor = nil
            self.contactImage.image = UIImage(systemName: "exclamationmark.triangle")
            return
        }
        
        imageLoadTask?.cancel()
        imageLoadTask = Task { [weak self] in
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    await MainActor.run {
                        self?.contactImage.backgroundColor = nil
                        self?.contactImage.image = image
                    }
                } else {
                    await MainActor.run {
                        self?.contactImage.backgroundColor = nil
                        self?.contactImage.image = UIImage(systemName: "exclamationmark.triangle")
                    }
                }
            } catch {
                await MainActor.run {
                    self?.contactImage.backgroundColor = nil
                    self?.contactImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            }
        }
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageLoadTask?.cancel()
        self.imageLoadTask = nil
        self.contactImage.image = nil
        self.fullnameLabel.text = nil
    }
}

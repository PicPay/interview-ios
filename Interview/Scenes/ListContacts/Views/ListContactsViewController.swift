import UIKit

class UserIdsLegacy {
    static let legacyIds = [10, 11, 12, 13]
    
    static func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}

class ListContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: String(describing: ContactCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var contacts = [Contact]()
    var viewModel: ListContactsViewModel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListContactsViewModel()
        configureViews()
        
        navigationController?.title = "Lista de contatos"
        
        loadData()
    }
    
    func configureViews() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func isLegacy(contact: Contact) -> Bool {
        return UserIdsLegacy.isLegacy(id: contact.id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCell.self), for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = contacts[indexPath.row]
        cell.fullnameLabel.text = contact.name
        
        if let urlPhoto = URL(string: contact.photoURL) {
            do {
                let data = try Data(contentsOf: urlPhoto)
                let image = UIImage(data: data)
                cell.contactImage.image = image
            } catch _ {}
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contato = contacts[indexPath.row - 1]
        
        guard isLegacy(contact: contato) else {
            let alert = UIAlertController(title: "Você tocou em", message: "\(contato.name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let alert = UIAlertController(title: "Atenção", message:"Você tocou no contato sorteado", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func loadData() {
        viewModel.loadContacts { contacts, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    
                    let alert = UIAlertController(title: "Ops, ocorreu um erro", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                
                self.contacts = contacts ?? []
                self.tableView.reloadData()
                self.activity.stopAnimating()
            }
        }
    }
}

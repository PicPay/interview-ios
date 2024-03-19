import UIKit

final class ListContactsViewController: UIViewController {
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
        tableView.allowsMultipleSelection = false
        return tableView
    }()
    
    var viewModel: ListContactsViewModel!
    private var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        title = "Lista de contatos"
        loadData()
    }
    
    private func configureViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func loadData() {
        viewModel = ListContactsViewModel()
        viewModel.loadContacts { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                switch result {
                case .success(let contacts):
                    self.contacts = contacts
                    self.tableView.reloadData()
                case .failure(let error):
                    AlertHelper.showErrorAlert(on: self, with: error.localizedDescription)
                }
            }
        }
    }
}

extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCell.self), for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = contacts[indexPath.row]
        cell.configure(with: contact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        if ListContactsViewModel.isLegacy(contactId: contact.id) {
            AlertHelper.showAlert(on: self, with: "Você tocou no contato sorteado")
        } else {
            AlertHelper.showAlert(on: self, with: "Você tocou em \(contact.name)")
        }
    }
}

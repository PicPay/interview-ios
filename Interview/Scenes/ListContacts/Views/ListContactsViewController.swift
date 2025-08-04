import UIKit

class ListContactsViewController: UIViewController {
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: String(describing: ContactCell.self))
        tableView.backgroundView = activity
        return tableView
    }()
    
    private var viewModel = ListContactsViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Lista de contatos"
        self.configureViews()
        self.bindingViewModel()
        Task {
            await viewModel.loadContacts()
        }
        
    }
    func configureViews() {
        self.setupViewHierarchy()
        self.setupConstraints()
    }

    private func setupViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func bindingViewModel() {
        viewModel.onViewStateChange = { [weak self] state in
            DispatchQueue.main.async {
                self?.handleViewState(state: state)
            }
        }
    }
    
    private func handleViewState(state: ViewState) {
        switch state {
        case .loading:
            self.activity.startAnimating()
        case .ready:
            self.activity.stopAnimating()
            self.tableView.reloadData()
        case .error(let error):
            self.handleError(error)
        }
    }
    
    private func handleError(_ error: ContactErrors) {
        let alert = UIAlertController(title: "Erro", message: error.errorDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ListContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCell.self), for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = viewModel.contactList[indexPath.row]
        cell.setupCell(with: contact)
        
        return cell
    }
    
    
}

extension ListContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedContact = viewModel.contactList[indexPath.row]
        
        var alertMessage = ("","")
        
        if UserIdsLegacy.isLegacy(id: selectedContact.id) {
            alertMessage = ("Atenção","Você tocou no contato sorteado")
        } else {
            alertMessage = ("Você tocou em",selectedContact.name)
        }
        
        let alert = UIAlertController(title: alertMessage.0, message:alertMessage.1, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)

    }
  
}



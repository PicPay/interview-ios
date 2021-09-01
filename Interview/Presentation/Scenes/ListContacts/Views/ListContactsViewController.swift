import UIKit

class ListContactsViewController: UIViewController {

    private var viewModel: ListContactsViewModelInput

    init(viewModel: ListContactsViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        return activity
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: String(describing: ContactCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = false
        return tableView
    }()

    override func loadView() {
        let view = UIView()
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.output = self
        configureViews()
        viewModel.fetchContacts()
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

        tableView.dataSource = self
        tableView.delegate = self

        bindViewModel()
    }
}

extension ListContactsViewController {
    func bindViewModel() {
        self.title = viewModel.title
    }
}

extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCell.self), for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }

        let cellViewModel = viewModel.contactViewModels[indexPath.row]
        cell.bindViewModel(viewModel: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onSelectItem(index: indexPath.row)
    }
}

extension ListContactsViewController: ListContactsViewModelOutput {

    func reloadData() {
        self.tableView.reloadData()
    }

    func showLoading() {
        self.activity.startAnimating()
    }

    func hideLoading() {
        self.activity.stopAnimating()
    }

    func showAlert(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func deselectRows() {
        self.tableView.indexPathsForSelectedRows?.forEach {
            self.tableView.deselectRow(at: $0, animated: true)
        }
    }
}

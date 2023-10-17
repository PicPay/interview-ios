import UIKit.UIViewController

final class ListContactsViewController: UIViewController {
    
    var viewModel: ListContactsViewModel
    
    private lazy var rootView: ListContactView = {
        let view = ListContactView(
            delegate: self,
            viewModel: self.viewModel
        )
        return view
    }()
    
    init(viewModel: ListContactsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.title = "Lista de contatos"
        viewModel.loadContacts()
    }
}

// MARK: - ListContactViewDelegate conforms

extension ListContactsViewController: ListContactViewDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        let contato = viewModel.viewData.contacts[indexPath.row]
        guard viewModel.isLegacy(id: contato.id) else {
            let alert = UIAlertController(title: "Você tocou em", message: "\(contato.name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let alert = UIAlertController(title: "Atenção", message:"Você tocou no contato sorteado", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - ViewModelDelegate conforms

extension ListContactsViewController: ListContactsViewModelDelegate {
    func didReceivedError(_ error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func contactDidLoaded() {
        DispatchQueue.main.async {
            self.rootView.tableView.reloadData()
        }
    }
}

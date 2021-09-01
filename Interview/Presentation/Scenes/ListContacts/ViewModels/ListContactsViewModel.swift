import Foundation

protocol ListContactsViewModelInput {
    var contactViewModels: [ContactCellViewModelInput] { get }
    var output: ListContactsViewModelOutput? { get set }
    var title: String { get }
    func fetchContacts()
    func onSelectItem(index: Int)
}

protocol ListContactsViewModelOutput {
    func reloadData()
    func showLoading()
    func hideLoading()
    func showAlert(title: String, message: String, button: String)
    func deselectRows()
}


class ListContactsViewModel: ListContactsViewModelInput {

    var output: ListContactsViewModelOutput?

    private(set) lazy var contactViewModels: [ContactCellViewModelInput] = {
        [ContactCellViewModelInput]()
    }()

    private(set) var title: String = "Lista de contatos"

    private var fetchContactsUseCase: FetchContactsUseCaseInput

    init(fetchContactsUseCase: FetchContactsUseCaseInput) {
        self.fetchContactsUseCase = fetchContactsUseCase
    }
    
    func fetchContacts() {
        self.output?.showLoading()
        fetchContactsUseCase.fetchContacts(output: self)
    }

    func onSelectItem(index: Int)  {
        let contactViewModel = contactViewModels[index]
        output?.deselectRows()
        if contactViewModel.isLegacy {
            output?.showAlert(title: "Atenção", message: "Você tocou no contato sorteado", button: "OK")
        } else {
            output?.showAlert(title: "Você tocou em", message: "\(contactViewModel.name)", button: "OK")
            return
        }
    }
}

extension ListContactsViewModel: FetchContactsUseCaseOutput {

    func onFecthContactsSuccess(contacts: [Contact]) {
        self.contactViewModels = contacts.map(ListContactsViewAssembler.makeContactCellViewModel)
        DispatchQueue.main.async { [weak self] in
            self?.output?.hideLoading()
            self?.output?.reloadData()
        }
    }

    func onFecthContactsFailed(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.output?.hideLoading()
            self?.handleError(error)
        }
    }
}

extension ListContactsViewModel {
    func handleError(_ error: Error) {
        output?.showAlert(title: "Ops, ocorreu um erro", message: error.localizedDescription, button: "OK")
    }
}

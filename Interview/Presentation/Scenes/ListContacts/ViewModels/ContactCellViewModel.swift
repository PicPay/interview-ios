//
//  ContactCellViewModel.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import UIKit

protocol ContactCellViewModelInput {
    var name: String { get }
    var isLegacy: Bool { get }

    func loadImage()
    func setOutput(output: ContactViewModelOutput?)
}

protocol ContactViewModelOutput {
    func setPhotoImage(image: UIImage?)
}
// MARK: ContactCellViewModelInput
final class ContactCellViewModel: ContactCellViewModelInput {

    var output: ContactViewModelOutput?
    private var contact: Contact!

    private var checkLegacyUsersUseCase: CheckLegacyUsersUseCaseType

    init(contact: Contact,
         checkLegacyUsersUseCase: CheckLegacyUsersUseCaseType) {
        self.contact = contact
        self.checkLegacyUsersUseCase = checkLegacyUsersUseCase
    }

    lazy var name: String = {
        self.contact.name
    }()

    lazy var isLegacy: Bool = {
        self.checkLegacyUsersUseCase.isLegacy(userId: contact.id)
    }()

    func loadImage() {
        self.setPlaceHolderImage()
        self.fecthImage()
    }

    func setOutput(output: ContactViewModelOutput?) {
        self.output = output
    }
}
// MARK: Private methods
extension ContactCellViewModel {

    private func distinctPhotoURL() -> String {
        self.contact.photoURL.appending("?k=\(contact.id)")
    }

    private func setPlaceHolderImage() {
        let placeholderImage: UIImage? = nil // or UIImage(named: "placeholder")
        self.notifyPhotoImageChanged(image: placeholderImage)
    }

    private func fecthImage() {
        if let urlPhoto = URL(string: self.distinctPhotoURL()) as NSURL? {
            ImageCache.publicCache.load(url: urlPhoto) { [weak self] (url, image) in
                guard self != nil else {
                    return
                }
                if let photoImage = image, urlPhoto == url {
                    self?.notifyPhotoImageChanged(image: photoImage)
                }
            }
        }
    }

    private func notifyPhotoImageChanged(image: UIImage?) {
        self.output?.setPhotoImage(image: image)
    }
}

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
        contact.name
    }()

    lazy var isLegacy: Bool = {
        checkLegacyUsersUseCase.isLegacy(userId: contact.id)
    }()

    func loadImage() {
        self.output?.setPhotoImage(image: nil) // or UIImage(named: "placeholder")
        if let urlPhoto = URL(string: contact.photoURL) as NSURL? {
            ImageCache.publicCache.load(url: urlPhoto) { [weak self] (url, image) in
                guard self != nil else {
                    return
                }
                if let photoImage = image, urlPhoto == url {
                    self?.output?.setPhotoImage(image: photoImage)
                }
            }
        }
    }

    func setOutput(output: ContactViewModelOutput?) {
        self.output = output
    }
}

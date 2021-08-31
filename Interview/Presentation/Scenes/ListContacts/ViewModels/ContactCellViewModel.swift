//
//  ContactCellViewModel.swift
//  Interview
//
//  Created by Lucas Ferreira Machado on 31/08/21.
//

import UIKit

protocol ContactViewModelInput {

    var output: ContactViewModelOutput! { get set }

    var name: String { get }

    func loadImage()
}

protocol ContactViewModelOutput {
    func setPhotoImage(image: UIImage?)
}

final class ContactCellViewModel: ContactViewModelInput {

    var output: ContactViewModelOutput!
    private var contact: Contact!

    private var checkLegacyUsersUseCase: CheckLegacyUsersUseCaseType

    init(contact: Contact,
         checkLegacyUsersUseCase: CheckLegacyUsersUseCaseType = CheckLegacyUsersUseCase()) {
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
}

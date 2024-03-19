//
//  AlertHelper.swift
//  Interview
//
//  Created by Jarede Lima on 19/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import UIKit

final class AlertHelper {
    static func showErrorAlert(on viewController: UIViewController, with message: String) {
        let alert = UIAlertController(title: "Ops, ocorreu um erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    static func showAlert(on viewController: UIViewController, with message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}

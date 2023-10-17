//
//  ViewCode.swift
//  Interview
//
//  Created by Bruno Alves on 17/10/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation
import UIKit.UIViewController

public protocol ViewCode where Self: UIView {
    /// Adds or remove subviews
    func setupHierarchy()
    /// Activate all layout constraints
    func setupConstraints()
    /// Setup views styles
    func setupViews()
}

public extension ViewCode {
    func setupViews() { }

    func applyViewCode() {
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
}

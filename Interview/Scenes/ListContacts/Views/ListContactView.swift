//
//  ListContactView.swift
//  Interview
//
//  Created by Bruno Alves on 17/10/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation
import UIKit.UIView

protocol ListContactViewDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
}

final class ListContactView: UIView, ViewCode {
    
    private var viewModel: ListContactsViewModel
    private weak var delegate: ListContactViewDelegate?
    
    // MARK: - View components
    
    private lazy var activity: UIActivityIndicatorView = {
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
        tableView.register(
            ContactCell.self,
            forCellReuseIdentifier: String(describing: ContactCell.self)
        )
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    // MARK: - Initializer
    
    init(delegate: ListContactViewDelegate, viewModel: ListContactsViewModel) {
        self.delegate = delegate
        self.viewModel = viewModel
        super.init(frame: .zero)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewCode conforms
    
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension ListContactView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewData.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: ContactCell.self),
            for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel.viewData.contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
}

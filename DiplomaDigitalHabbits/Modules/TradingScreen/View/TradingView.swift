//
//  TradingView.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 27.10.2021.
//

import UIKit

class TradingView: UIView {
    // MARK: - Variables
    let tableView = UITableView()
    let refreshControll = UIRefreshControl()

    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        addSubview(tableView)
        
        refreshControll.tintColor = .systemGray2
        tableView.addSubview(refreshControll)
        
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: - Private Methods
    private func setConstraints() {
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

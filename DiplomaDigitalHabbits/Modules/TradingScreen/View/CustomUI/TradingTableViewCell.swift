//
//  TradingTableViewCell.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 27.10.2021.
//

import UIKit

class TradingTableViewCell: UITableViewCell {

    static let cellId = "TradingView"
    
    // MARK: - UI Elems
    let label = UILabel()
    let price = UILabel()
    let totalAmount = UILabel()
    let currentPrice = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white
        selectionStyle = .none

        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        price.textColor = .black
        price.textAlignment = .right
        price.translatesAutoresizingMaskIntoConstraints = false
        addSubview(price)

        totalAmount.textColor = .black
        totalAmount.textAlignment = .right
        totalAmount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(totalAmount)

        currentPrice.textColor = .black
        currentPrice.textAlignment = .right
        currentPrice.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currentPrice)

        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    public func setUpCell(data: Crypto) {
        price.text = "\(data.price)$"
        label.text = data.tokenName
        totalAmount.text = "\(data.tokenCount) шт"
        currentPrice.text = "0.000012"
    }

    // MARK: - Private Methods

    private func makeConstraints() {
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(self.frame.width / 2)).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true

        currentPrice.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        currentPrice.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currentPrice.heightAnchor.constraint(equalToConstant: 30).isActive = true
        currentPrice.widthAnchor.constraint(equalToConstant: 100).isActive = true

        totalAmount.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        totalAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        totalAmount.heightAnchor.constraint(equalToConstant: 16).isActive = true
        totalAmount.leadingAnchor.constraint(equalTo: currentPrice.trailingAnchor).isActive = true

        price.topAnchor.constraint(equalTo: totalAmount.bottomAnchor, constant: 8).isActive = true
        price.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        price.leadingAnchor.constraint(equalTo: totalAmount.leadingAnchor).isActive = true
        price.trailingAnchor.constraint(equalTo: totalAmount.trailingAnchor).isActive = true

    }
}

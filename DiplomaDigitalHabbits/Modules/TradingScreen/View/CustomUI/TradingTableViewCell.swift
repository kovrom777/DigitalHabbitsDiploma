//
//  TradingTableViewCell.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 27.10.2021.
//

import UIKit

class TradingTableViewCell: UITableViewCell {

    static let cellId = "TradingView"
    
    let label = UILabel()
    let price = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        price.textColor = .black
        price.textAlignment = .center
        price.translatesAutoresizingMaskIntoConstraints = false
        addSubview(price)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(self.frame.width / 2)).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        price.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
        price.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        price.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20).isActive = true
        price.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
    }
}

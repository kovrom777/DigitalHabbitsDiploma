//
//  AddNewRecordView.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//

import UIKit

class AddNewRecordView: UIView {

    let tokenLabel = UITextField()
    let datePicker = UIDatePicker()
    let boughtAmount = UITextField()
    let tokenAmount = UITextField()
    let addNewRecordButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray

        tokenLabel.placeholder = "  Token"
        tokenLabel.layer.cornerRadius = 16
        tokenLabel.layer.borderColor = UIColor.white.cgColor
        tokenLabel.layer.borderWidth = 2
        tokenLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tokenLabel)

        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "RU")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(datePicker)
        
        boughtAmount.placeholder = "  Цена покупки"
        boughtAmount.layer.cornerRadius = 16
        boughtAmount.layer.borderColor = UIColor.white.cgColor
        boughtAmount.layer.borderWidth = 2
        boughtAmount.translatesAutoresizingMaskIntoConstraints = false
        boughtAmount.keyboardType = .decimalPad
        addSubview(boughtAmount)

        tokenAmount.placeholder = "  Количество токенов"
        tokenAmount.layer.cornerRadius = 16
        tokenAmount.layer.borderColor = UIColor.white.cgColor
        tokenAmount.layer.borderWidth = 2
        tokenAmount.translatesAutoresizingMaskIntoConstraints = false
        tokenAmount.keyboardType = .numberPad
        addSubview(tokenAmount)

        addNewRecordButton.setTitle("Сохранить Запись", for: .normal)
        addNewRecordButton.setTitleColor(.black, for: .normal)
        addNewRecordButton.layer.cornerRadius = 16
        addNewRecordButton.backgroundColor = .white
        addNewRecordButton.translatesAutoresizingMaskIntoConstraints = false
        addNewRecordButton.layer.borderColor = UIColor.black.cgColor
        addNewRecordButton.layer.borderWidth = 2
        addSubview(addNewRecordButton)

        setConstraints()
    }

    private func setConstraints() {
        tokenLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        tokenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        tokenLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        tokenLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        datePicker.topAnchor.constraint(equalTo: tokenLabel.bottomAnchor, constant: 16).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: tokenLabel.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: tokenLabel.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 40).isActive = true

        boughtAmount.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16).isActive = true
        boughtAmount.leadingAnchor.constraint(equalTo: tokenLabel.leadingAnchor).isActive = true
        boughtAmount.trailingAnchor.constraint(equalTo: tokenLabel.trailingAnchor).isActive = true
        boughtAmount.heightAnchor.constraint(equalToConstant: 40).isActive = true

        tokenAmount.topAnchor.constraint(equalTo: boughtAmount.bottomAnchor, constant: 16).isActive = true
        tokenAmount.leadingAnchor.constraint(equalTo: tokenLabel.leadingAnchor).isActive = true
        tokenAmount.trailingAnchor.constraint(equalTo: tokenLabel.trailingAnchor).isActive = true
        tokenAmount.heightAnchor.constraint(equalToConstant: 40).isActive = true

        addNewRecordButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        addNewRecordButton.leadingAnchor.constraint(equalTo: tokenLabel.leadingAnchor).isActive = true
        addNewRecordButton.trailingAnchor.constraint(equalTo: tokenLabel.trailingAnchor).isActive = true
        addNewRecordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

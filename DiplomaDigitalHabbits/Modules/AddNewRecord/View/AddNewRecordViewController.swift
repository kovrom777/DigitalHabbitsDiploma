//
//  AddNewRecordViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//

import UIKit

protocol AddNewRecordDelegate {
    func updateVC()
}

class AddNewRecordViewController: UIViewController {
    // MARK: - Local variables
    let contentView = AddNewRecordView()
    let coreDataManager = CoreDataStack.shared
    let isStock: Bool
    var delegate: AddNewRecordDelegate?
    // MARK: - Init
    init(isStock: Bool) {
        self.isStock = isStock
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.addNewRecordButton.addTarget(self, action: #selector(saveToCoreData), for: .touchUpInside)
        addDoneButtonOnKeyboard()
    }

    override func loadView() {
        view = contentView
    }

    // MARK: - Private Methods
    func addDoneButtonOnKeyboard() {
        [contentView.tokenLabel, contentView.tokenAmount, contentView.boughtAmount].forEach({$0.addDoneButtonOnKeyboard()})
    }

    @objc private func saveToCoreData() {
        addNew()
    }

    private func addNew() {
        guard let tokenName = contentView.tokenLabel.text else {return}
        let date = contentView.datePicker.date
        guard let price = contentView.boughtAmount.text else {return}
        guard let totalCount = contentView.tokenAmount.text else {return}

        if isStock {
            coreDataManager.writeStockData(tokenName: tokenName, price: Float(price) ?? 1.0, dateOfPurchase: date, stockCount: Int16(totalCount) ?? 1) {
                self.dismiss(animated: true) {
                    self.delegate?.updateVC()
                }
            }
        } else {
            coreDataManager.writeCryptoData(tokenName: tokenName.replacingOccurrences(of: " ", with: ""), date: date, price: Float(price) ?? 1, totalCount: Int16(totalCount) ?? 1) {
                self.dismiss(animated: true) {
                    self.delegate?.updateVC()
                }
            }
        }
    }
}

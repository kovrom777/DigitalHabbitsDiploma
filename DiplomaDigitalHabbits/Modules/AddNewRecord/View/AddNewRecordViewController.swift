//
//  AddNewRecordViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//

import UIKit

class AddNewRecordViewController: UIViewController {
    // MARK: - Local variables
    let contentView = AddNewRecordView()
    let coreDataManager = CoreDataStack.shared
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.addNewRecordButton.addTarget(self, action: #selector(saveToCoreData), for: .touchUpInside)
        addDoneButtonOnKeyboard()
        addGuesture()
    }

    override func loadView() {
        view = contentView
    }

    // MARK: - Private Methods
    
    private func addGuesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        contentView.addGestureRecognizer(tap)
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 320, height: 50))

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(doneButtonAction))
        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
        [contentView.tokenLabel, contentView.tokenAmount, contentView.boughtAmount].forEach({
            $0.inputAccessoryView = doneToolbar
        })
    }

    @objc private func doneButtonAction() {
        view.endEditing(true)
//        self.contentView.tokenAmount.resignFirstResponder()
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func saveToCoreData() {
        addNew()
    }

    private func addNew() {
        guard let tokenName = contentView.tokenLabel.text else {return}
        let date = contentView.datePicker.date
        guard let price = contentView.boughtAmount.text else {return}
        guard let totalCount = contentView.tokenAmount.text else {return}
        let totalPrice = Float(price) ?? 1 * Float(totalCount)!

        let writeContext = coreDataManager.container.newBackgroundContext()

        writeContext.performAndWait {
            let crypto = Crypto(context: writeContext)
            crypto.tokenName = tokenName
            crypto.dateOfPurchase = date
            crypto.price = Float(price) ?? 0
            crypto.tokenCount = Int16(totalCount) ?? 1
            crypto.totalAmount = totalPrice
            do {
                try writeContext.save()
                print("New Token added")
                self.dismiss(animated: true, completion: nil)
            } catch {
                print("Error while adding new record \(error.localizedDescription)")
            }
        }
    }

}

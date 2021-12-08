//
//  ChartsViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 07.12.2021.
//

import UIKit

class ChartsViewController: UIViewController {

    var contentView: ChartsView// = ChartsView(dataSets: [], title: "")
    let dataSet: [CGFloat]
    let titleForScreen: String
    init(dataSet: [CGFloat], title: String) {
        self.dataSet = dataSet
        self.titleForScreen = title
        contentView = ChartsView(dataSets: dataSet, title: title)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = contentView
    }
}

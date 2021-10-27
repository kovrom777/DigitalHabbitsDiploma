//
//  ViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 16.09.2021.
//

import UIKit

class TradingViewController: UIViewController {
    
    weak var coordinator: TradingCoordinator?
    let contentView = TradingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        WebSocketManager.shared.connectToWebSocket()
        WebSocketManager.shared.subscribeOnSMTH()
        
    }
    
    func getData(){
        WebSocketManager.shared.receiveData { model in
            print(model)
        }
    }
    
    func setupTableView(){
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(TradingTableViewCell.self, forCellReuseIdentifier: TradingTableViewCell.cellId)
    }

    override func loadView() {
        view = contentView
    }
    
}

extension TradingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TradingTableViewCell.cellId, for: indexPath) as? TradingTableViewCell else {return UITableViewCell()}
        cell.price.text = "444"
        cell.label.text = "TSLA"
        return cell
    }
    
    
}

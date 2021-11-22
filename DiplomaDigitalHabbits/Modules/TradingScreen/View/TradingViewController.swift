//
//  ViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 16.09.2021.
//

import UIKit
import CoreData

class TradingViewController: UIViewController {
    
    // MARK: - Variables
    weak var coordinator: TradingCoordinator?
    let contentView = TradingView()
    let coreDataManager = CoreDataStack.shared
    var crypto: [Crypto]?
    private var service: NetworkServiceProtocol
    
    // MARK: - Init
    
    init(service: NetworkServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - View controller LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crypto = coreDataManager.loadDataForCrypto()
        contentView.tableView.reloadData()
        toggleWebSocket()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadData()
    }

    override func loadView() {
        view = contentView
    }

    // MARK: - Private methods
    private func getData() {
        WebSocketManager.shared.receiveData { model in
            print(model)
        }
    }
    
    private func toggleWebSocket() {
        if SettingsModel.shared.useWebSocket {
            WebSocketManager.shared.connectToWebSocket()
            WebSocketManager.shared.subscribeOnSMTH()
        }
    }

    private func configureView() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus")?.withTintColor(.white),
            style: .plain,
            target: self,
            action: #selector(plusButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(showSettingScreen))
        setupTableView()
    }

    private func setupTableView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(TradingTableViewCell.self, forCellReuseIdentifier: TradingTableViewCell.cellId)
    }
    
    private func loadData() {
        service.requestPrice(symbol: "AAPL") { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let err):
                print(err.localizedDescription)
            case .success:
                print("Success")
            }
        }
    }

    // MARK: - Button Actions
    @objc func showSettingScreen() {
        self.coordinator?.presentSettingsScreen()
    }

    @objc private func plusButtonTapped() {
        self.coordinator?.presentAddNewRecord(viewController: self)
    }
}

// MARK: - Extension

extension TradingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crypto?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TradingTableViewCell.cellId, for: indexPath) as? TradingTableViewCell else {
            return UITableViewCell()
        }
        guard let dopCrypto = crypto else {
            return UITableViewCell()
        }
        cell.setUpCell(data: dopCrypto[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

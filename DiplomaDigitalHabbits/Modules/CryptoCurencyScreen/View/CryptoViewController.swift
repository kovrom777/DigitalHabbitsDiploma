//
//  CryptoViewController.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 26.10.2021.
//

import UIKit

class CryptoViewController: UIViewController {

    // MARK: - Variables
    let contentView = CryptoView()
    weak var coordinator: CryptoCoordinator?
    let coreDataManager = CoreDataStack.shared
    let service: NetworkServiceProtocol
    var crypto: [Crypto]?
    var cryptoData = [TradingModel]()

    // MARK: - Init
    init(service: NetworkServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
        configureView()
    }

    override func loadView() {
        view = contentView
    }

    // MARK: - PrivateMethods
    private func loadInfo() {
        crypto = coreDataManager.loadDataForCrypto()
        for token in crypto ?? [] {
            let token = "\(token.tokenName?.replacingOccurrences(of: " ", with: "").uppercased() ?? "")/USD"
            let endPoint = TradingPriceEndPoint(
                symbol: "\(token)",
                key: coordinator?.keyChain.object(for: GenericKey(key: "key")) ?? "")
            service.requestWithEndPoint(endPoint: endPoint) { result in
                switch result {
                case .success(let data):
                    self.cryptoData.append(data!)
                    if self.cryptoData.count == self.crypto?.count ?? 0 {
                        self.contentView.tableView.reloadData()
                    }
                case .failure(let error):
                    AlertService.presentErrorAlert(vc: self, title: "Ошибка", message: error.message)
                }
            }
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

        contentView.refreshControll.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    }

    @objc private func refresh(sender: AnyObject) {
        print("Updating")
        loadInfo()
        contentView.refreshControll.endRefreshing()
    }

    private func setupTableView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(TradingTableViewCell.self, forCellReuseIdentifier: TradingTableViewCell.cellId)
    }

    // MARK: - Button Actions
    @objc func showSettingScreen() {
        self.coordinator?.presentSettingsScreen()
    }

    @objc private func plusButtonTapped() {
        self.coordinator?.presentAddNewRecord(viewController: self, isStock: false)
    }
}

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crypto?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TradingTableViewCell.cellId, for: indexPath) as? TradingTableViewCell else {
            return UITableViewCell()
        }
        guard let dopCrypto = crypto else {return UITableViewCell()}
        guard let cryptoName = dopCrypto[indexPath.row].tokenName else {
            return UITableViewCell()
        }
        var currentPrice = 0.0
        for crypto in cryptoData {
            if crypto.meta?.symbol ?? "" == "\(cryptoName.replacingOccurrences(of: " ", with: "").uppercased())/USD" {
                currentPrice = Double(crypto.values?.first?.open ?? "") ?? 0.0
            }
        }
        cell.setUpCellForCrypto(data: dopCrypto[indexPath.row], currentPriceValue: currentPrice)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockName = cryptoData[indexPath.row].meta?.symbol
        var dataSet = [CGFloat]()

        cryptoData[indexPath.row].values?.forEach({
            let dooo = Double($0.close)
            dataSet.append(CGFloat(dooo ?? 0.0))
        })
        print(dataSet)

        coordinator?.showCharts(viewcontroller: self, dataSet: dataSet, title: stockName ?? "")
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let crypto = crypto?[indexPath.row] else {
                return
            }
            coreDataManager.deleteCrypto(crypto: crypto) {
                self.loadInfo()
                self.contentView.tableView.reloadData()
            }
        }
    }
}

extension CryptoViewController: AddNewRecordDelegate {
    func updateVC() {
        loadInfo()
        contentView.tableView.reloadData()
    }
}

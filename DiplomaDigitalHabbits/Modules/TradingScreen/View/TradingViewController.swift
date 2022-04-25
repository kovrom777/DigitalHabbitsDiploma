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
    var stocks: [Stock]?
    private var service: NetworkServiceProtocol
    private var stockData = [TradingModel]()
    private var logos = [LogoModel]()
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
        loadInfo()
        contentView.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadInfo()
    }

    override func loadView() {
        view = contentView
    }

    // MARK: - Private methods

    private func loadInfo () {
        stocks = coreDataManager.loadDataForStocks()
        stockData.removeAll()
        for stock in stocks ?? [] {
            let key = coordinator?.keyChain.object(for: GenericKey(key: "key")) ?? ""
            let endPoint = TradingPriceEndPoint(symbol: stock.stockName ?? "", key: key)
            service.requestWithEndPoint(endPoint: endPoint) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .failure(let err):
                    print(err.message)
                    AlertService.presentErrorAlert(vc: self, title: "Ошибка", message: err.message)
                case .success(let data):
                    self.stockData.append(data!)
                    if self.stockData.count == self.stocks?.count ?? 0 {
                        self.contentView.tableView.reloadData()
                        self.loadLogos()
                    }
                }
            }
        }
    }
    
    private func loadLogos(){
        stocks = coreDataManager.loadDataForStocks()
        let key = coordinator?.keyChain.object(for: GenericKey(key: "key")) ?? ""
        for stock in stocks ?? [] {
            let logoEndPoint = LogoEndPoint(symbol: stock.stockName ?? "", key: key)
            self.service.process(endPoint: logoEndPoint) { result in
                switch result {
                case .success(let elem):
                    self.logos.append(elem)
                    if self.logos.count == self.stocks?.count ?? 0 {
                        self.contentView.tableView.reloadData()
                    }
                case .failure(_):
                    print("error")
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
        self.coordinator?.presentAddNewRecord(viewController: self, isStock: true)
    }
}

// MARK: - Extension

extension TradingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TradingTableViewCell.cellId,
            for: indexPath) as? TradingTableViewCell else {
            return UITableViewCell()
        }
        guard let dopCrypto = stocks, let stockName = dopCrypto[indexPath.row].stockName else {
            return UITableViewCell()
        }
        var currentPrice = 0.0
        var image: Data?
        for stock in stockData {
            if stock.meta?.symbol ?? "" == stockName.replacingOccurrences(of: " ", with: "").uppercased() {
                currentPrice = Double(stock.values?.first?.open ?? "") ?? 0.0
            }
        }

        for logo in logos {
            if logo.symbol ?? "" == stockName.replacingOccurrences(of: " ", with: "").uppercased() {
                image = logo.data
            }
        }
        cell.setUpCell(data: dopCrypto[indexPath.row], currentPriceValue: currentPrice, image: image)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dopCrypto = stocks, let stockName = dopCrypto[indexPath.row].stockName else {
            return
        }
        var dataSet = [CGFloat]()

        stockData[indexPath.row].values?.forEach({
            let dooo = Double($0.close)
            dataSet.append(CGFloat(dooo ?? 0.0))
        })
        print(dataSet)

        coordinator?.showCharts(viewcontroller: self, dataSet: dataSet, title: stockName)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let stock = stocks?[indexPath.row] else {
                return
            }
            coreDataManager.deleteStock(stock: stock, onSuccess: {
                self.loadInfo()
                self.contentView.tableView.reloadData()
            })
        }
    }
}

extension TradingViewController: AddNewRecordDelegate {
    func updateVC() {
        loadInfo()
        contentView.tableView.reloadData()
    }
}

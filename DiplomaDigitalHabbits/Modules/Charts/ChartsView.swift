//
//  ChartsView.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 07.12.2021.
//

import UIKit
import CareKitUI

class ChartsView: UIView {

    // MARK: - Properties
    let chartView = OCKCartesianChartView(type: .line)
    let backButton = UIButton()
    let dataSet: [CGFloat]
    let title: String
    // MARK: - Inits
    init(dataSets: [CGFloat], title: String) {
        self.dataSet = dataSets
        self.title = title
        super.init(frame: .zero)
        backgroundColor = .white
        chartView.headerView.titleLabel.text = title
        
        var series = OCKDataSeries(values: dataSets, title: "График стоиомсти")
//        var series = OCKDataSeries(values: [15.573, 15.515, 15.53, 15.54, 15.5301, 15.595, 15.63, 15.645, 15.7, 15.7691, 15.715, 15.745, 15.725, 15.6, 15.61, 15.555, 15.37,
//                                            15.42, 15.54, 14.64, 14.667, 14.68, 14.6891, 14.7499, 14.76, 14.81, 14.8111, 14.85, 14.83, 14.805]
//, title: "title")
        series.size = 2
        chartView.graphView.dataSeries = [series]
        chartView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chartView)

        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private methods
    
    public func configureData(values: [Value]) {
        var arr = [Float]()
        for value in values {
            arr.append(Float(value.close) ?? 0.0)
        }
//        OCKDataSeries(values: arr, title: "")
    }
    
    // MARK: - Private methods
    private func setConstraints() {
        chartView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        chartView.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

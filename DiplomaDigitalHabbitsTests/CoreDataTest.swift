//
//  CoreDataTest.swift
//  DiplomaDigitalHabbitsTests
//
//  Created by Роман Ковайкин on 08.12.2021.
//

import XCTest
@testable import DiplomaDigitalHabbits

class CoreDataTest: XCTestCase {

    let manager = CoreDataStack.shared
    
    func testFetchingDataForStocks() {
        let stocks = manager.loadDataForStocks()
        do {
            let resp = try XCTUnwrap(stocks)
            XCTAssertNotEqual(resp.count, 0, "There are no records for stocks")
        } catch {
            XCTFail("unable to unwrap stock data")
        }
    }
    
    func testFetchingDataForCrypto() {
        let crypto = manager.loadDataForCrypto()
        do {
            let resp = try XCTUnwrap(crypto)
            XCTAssertNotEqual(resp.count, 0, "There are no records for crypto")
        } catch {
            XCTFail("unable to unwrap data for crypto")
        }
    }

    func testRecordingNewStock() {
        let oldCount = manager.loadDataForStocks()
        manager.writeStockData(tokenName: "Testable", price: 0.4, dateOfPurchase: Date(), stockCount: 1) {
            XCTAssertTrue(true)
        }
        let newCount = manager.loadDataForStocks()
        XCTAssertEqual((oldCount?.count ?? 0) + 1, newCount?.count ?? 0)
    }

    func testRecordingNewCrypto() {
        let oldCount = manager.loadDataForCrypto()
        manager.writeCryptoData(tokenName: "testable", date: Date(), price: 0.32, totalCount: 12) {
            XCTAssertTrue(true)
        }

        let newCount = manager.loadDataForCrypto()
        XCTAssertEqual((oldCount?.count ?? 0) + 1, newCount?.count ?? 0)
    }
}

//
//  WalletManagerTests.swift
//  ArgentAssessmentTests
//
//  Created by Victor Nouvellet on 22/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import XCTest
import web3
import BigInt
@testable import ArgentAssessment

class WalletManagerTests: XCTestCase {
    
    var walletManager: WalletManager!
    let timeout = 10.0

    override func setUp() {
        walletManager = WalletManager()
    }

    override func tearDown() {
        walletManager = nil
    }
    
    func testGetBalance() {
        let expectation = XCTestExpectation(description: "get remote wallet balance")
        walletManager.getCurrentBalance { result in
            switch result {
            case let .success(balance):
                XCTAssertGreaterThanOrEqual(balance, 0)
            default:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: timeout)
    }

    func testCreateTransaction() {
        let transaction = try? walletManager.createTransaction(amount: 10)
        XCTAssertNotNil(transaction)
    }
    
    func testGetTransfersList() {
        let expectation = XCTestExpectation(description: "get list of all received ERC20 transfers for the Argent wallet")
        walletManager.getTransfersList { result in
            switch result {
            case let .success(transfers):
                XCTAssertGreaterThanOrEqual(transfers.count, 8)
            default:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: timeout)
    }
}

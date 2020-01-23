//
//  MainInteractor.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import BigInt
import web3

enum MainInteractorProtocolError: Error {
    case transactionCreationFailed
}

protocol MainInteractorProtocol {
    var callbackModelUpdate: (_ model: MainViewModel) -> () { get set }
    func start()
    func onViewDidAppear()
    func updateBalance()
    func send(completion: @escaping (Result<String, Error>) -> Void)
}

class MainInteractor {
    
    // MARK: - Injected vars
    
    weak var view: MainViewControllerProtocol!
    var walletManager: WalletManagerProtocol!
    
    // MARK: - Private vars
    
    private var model: MainViewModel = MainViewModel.defaultModel() { didSet { self.onModelUpdate()  }  }
    
    // MARK: - Internal vars
    
    var callbackModelUpdate : (_ model: MainViewModel) -> () = {_ in }
}

// MARK: - MainInteractorProtocol methods

extension MainInteractor: MainInteractorProtocol {
    
    func start() {
        let newModel = MainViewModel.defaultModel()
        self.model = newModel
    }
    
    func onViewDidAppear() {
        self.updateBalance()
    }
    
    func updateBalance() {
        self.model = MainViewModel(walletBalance: nil)
        self.walletManager.getCurrentBalance { result in
            DispatchQueue.main.async(execute: { [weak self] in
                switch result {
                case .failure(let error):
                    self?.handleClientError(withError: error)
                case .success(let balance):
                    let etherBalance = balance.weiToEther(decimals: 2)
                    self?.model = MainViewModel(walletBalance: "\(etherBalance) ETH")
                }
            })
        }
    }
    
    func send(completion: @escaping (Result<String, Error>) -> Void) {
        let amount: BigUInt = 10000000000000000
        self.sendETH(withAmount: amount, completion: completion)
    }
}

// MARK: - Private methods

private extension MainInteractor {
    
    func handleClientError(withError error: Error) {
        switch error {
        default:
            self.model = MainViewModel(walletBalance: "Unexpected error fetching balance")
        }
    }
    
    func sendETH(withAmount amount: BigUInt, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let transaction = try self.walletManager.createTransaction(amount: amount)
            self.walletManager.sendTransaction(transaction, completion: completion)
        } catch {
            completion(.failure(MainInteractorProtocolError.transactionCreationFailed))
        }
    }
    
    //MARK: Model handler
    
    func onModelUpdate() {
        callbackModelUpdate(self.model)
    }
}

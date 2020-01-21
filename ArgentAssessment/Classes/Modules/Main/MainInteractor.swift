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
    case noModelToSave
}

protocol MainInteractorProtocol {
    var callbackModelUpdate: (_ model: MainViewModel) -> () { get set }
    func start()
    func onViewDidAppear()
    func send(completion: (Result<String, Error>) -> Void)
}

class MainInteractor {
    
    // MARK: - Injected vars
    
    weak var view: MainViewControllerProtocol!
    
    // MARK: - Private vars
    
    private var model: MainViewModel = MainViewModel.defaultModel() { didSet { self.onModelUpdate()  }  }
    
    // MARK: - Internal vars
    
    var callbackModelUpdate : (_ model: MainViewModel) -> () = {_ in }
}

extension MainInteractor: MainInteractorProtocol {
    
    func start() {
        let newModel = MainViewModel.defaultModel()
        self.model = newModel
    }
    
    func onViewDidAppear() {
        // TODO
    }
    
    func send(completion: (Result<String, Error>) -> Void) {
        let amount = BigInt(10000000000000000)
        self.sendETH(withAmount: amount, completion: completion)
    }
    
    //MARK: Model handler
    
    func onModelUpdate() {
        callbackModelUpdate(self.model)
    }
}

private extension MainInteractor {
    
    func sendETH(withAmount amount: BigInt, completion: (Result<String, Error>) -> Void) {
        // TODO: Make request to Infura using web3
        completion(.success("0xEEEEEEEEEEEEEEEE"))
    }
}

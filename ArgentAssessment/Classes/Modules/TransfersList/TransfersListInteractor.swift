//
//  TransfersListInteractor.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import web3

protocol TransfersListInteractorProtocol {
    var callbackModelUpdate: (_ model: TransfersListViewModel) -> () { get set }
    func onViewDidLoad()
    func onViewDidAppear(completion: (() -> Void)?)
    func onTransfersListManualRefresh(completion: (() -> Void)?)
}

final class TransfersListInteractor {
    
    // MARK: Injected vars
    
    weak var view: TransfersListViewControllerProtocol!
    var walletManager: WalletManagerProtocol!
    
    // MARK: Private vars
    
    private var model = TransfersListViewModel.defaultModel() { didSet { self.onModelUpdate(model) } }
    
    // MARK: Internal vars
    
    var callbackModelUpdate: (_ model: TransfersListViewModel) -> () = { _ in }
}

// MARK: - Internal methods

extension TransfersListInteractor: TransfersListInteractorProtocol {
    func onViewDidLoad() {
        self.model = TransfersListViewModel.defaultModel()
    }
    
    func onViewDidAppear(completion: (() -> Void)?) {
        self.updateTransfersList(completion: completion)
    }
    
    func onTransfersListManualRefresh(completion: (() -> Void)?) {
        self.updateTransfersList(completion: completion)
    }
}

// MARK: - Private methods

private extension TransfersListInteractor {
    
    func getTransfers(completion: @escaping (Result<[ERC20Events.Transfer], Error>) -> Void) {
        self.walletManager.getTransfersList(completion: completion)
    }
    
    func updateTransfersList(completion: (() -> Void)? = nil) {
        self.getTransfers { result in
            DispatchQueue.main.async(execute: { [weak self] in
                completion?()
                guard case let .success(transfers) = result else {
                    self?.model = TransfersListViewModel.defaultModel()
                    return
                }
                let transfersModels = transfers.compactMap { transfer -> TransfersListTransferViewModel? in
                    guard let txHash = transfer.log.transactionHash else { return nil }
                    return TransfersListTransferViewModel(
                        txHash: txHash,
                        fromAddress: transfer.from.value,
                        token: transfer.log.address.value,
                        amount: "\(transfer.value)"
                    )
                }
                self?.model = TransfersListViewModel(transfersList: transfersModels.reversed())
            })
        }
    }
    
    // MARK: Model handler
    /// Should not be used directly
    func onModelUpdate(_ newModel: TransfersListViewModel) {
        callbackModelUpdate(newModel)
    }
}


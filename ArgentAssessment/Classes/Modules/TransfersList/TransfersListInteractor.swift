//
//  TransfersListInteractor.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

protocol TransfersListInteractorInterface {
    var callbackModelUpdate: (_ model: TransfersListViewModel) -> () { get set }
    func onViewDidLoad()
}

final class TransfersListInteractor {
    // MARK: - Injected vars
    
    weak var view: TransfersListViewController!
    
    // MARK: - Private vars
    
    private var model = TransfersListViewModel.defaultModel() { didSet { self.onModelUpdate(model) } }
    
    // MARK: - Internal vars
    
    var callbackModelUpdate: (_ model: TransfersListViewModel) -> () = { _ in }
}

// MARK: - Internal methods

extension TransfersListInteractor: TransfersListInteractorInterface {
    func onViewDidLoad() {
        self.model = TransfersListViewModel.mockModel()
    }
}

// MARK: - Private methods

private extension TransfersListInteractor {
    
    // MARK: Model handler
    /// Should not be used directly
    func onModelUpdate(_ newModel: TransfersListViewModel) {
        callbackModelUpdate(newModel)
    }
}


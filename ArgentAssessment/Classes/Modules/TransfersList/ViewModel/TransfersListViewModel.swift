//
//  TransfersListViewModel.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct TransfersListViewModel {
    let transfersList: [TransfersListTransferViewModel]?
    
    static func defaultModel() -> TransfersListViewModel {
        return TransfersListViewModel(transfersList: nil)
    }
}

//
//  TransfersListTransferViewModel.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 22/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct TransfersListTransferViewModel {
    let txHash: String
    let fromAddress: String
    let token: String
    let amount: String
}

extension TransfersListTransferViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(txHash)
    }
}

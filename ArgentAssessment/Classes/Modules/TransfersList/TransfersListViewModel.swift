//
//  TransfersListViewModel.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct TransfersListTransferViewModel {
    let identifier = UUID()
    let fromAddress: String
    let token: String
    let amount: String
}

extension TransfersListTransferViewModel: Hashable { }

struct TransfersListViewModel {
    let transfersList: [TransfersListTransferViewModel]?
    
    static func defaultModel() -> TransfersListViewModel {
        return TransfersListViewModel(transfersList: nil)
    }
    
    static func mockModel() -> TransfersListViewModel {
        let transfers: [TransfersListTransferViewModel] = [
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000EEEEEEEEEE",
                token: "0x000EEEEEEEEEE",
                amount: "250"
            ),
            TransfersListTransferViewModel(
                fromAddress: "0x000AAAAAAAAA",
                token: "0x000AAAAAAAAA",
                amount: "100"
            )
        ]
        return TransfersListViewModel(transfersList: transfers)
    }
}

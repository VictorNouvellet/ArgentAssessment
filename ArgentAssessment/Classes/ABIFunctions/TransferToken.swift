//
//  TransferToken.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import web3
import BigInt

struct TransferToken: ABIFunction {
    static let name = "transferToken"
    var gasPrice: BigUInt? = BigUInt(12000000000)
    var gasLimit: BigUInt? = BigUInt(250000)
    var contract: EthereumAddress
    var from: EthereumAddress?
    
    // MARK: Inputs
    let wallet: EthereumAddress
    let token: EthereumAddress
    let to: EthereumAddress
    let amount: BigUInt
    let data: Data = Data()
    
    func encode(to encoder: ABIFunctionEncoder) throws {
        try encoder.encode(wallet)
        try encoder.encode(token)
        try encoder.encode(to)
        try encoder.encode(amount)
        try encoder.encode(data)
    }
}

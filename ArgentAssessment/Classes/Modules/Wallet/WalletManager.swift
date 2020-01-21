//
//  WalletManager.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import Combine
import BigInt
import web3

class WalletManager {
    
    // MARK: Account vars
    private let keyStorage: EthereumKeyLocalStorage = {
        let storage = EthereumKeyLocalStorage()
        let privateKey: String = "0xec983791a21bea916170ee0aead71ab95c13280656e93ea4124c447bbd9a24a2"
        try? storage.storePrivateKey(key: privateKey.web3.keccak256fromHex)
        return storage
    }()
    private lazy var account: EthereumAccount? = {
        try? EthereumAccount(keyStorage: self.keyStorage)
    }()
    
    // MARK: Client vars
    private let clientUrl = URL(string: "https://ropsten.infura.io/v3/735489d9f846491faae7a31e1862d24b")!
    private lazy var client: EthereumClient = EthereumClient(url: clientUrl)
    
    // MARK: Argent
    let argentWalletAddress = "0x70ABd7F0c9Bdc109b579180B272525880Fb7E0cB"
    let transferManagerModuleAddress = "0xcdAd167a8A9EAd2DECEdA7c8cC908108b0Cc06D1"

    func getCurrentBalance(completion: @escaping (Result<BigUInt, EthereumClientError>) -> Void) {
        self.client.eth_getBalance(address: argentWalletAddress, block: .Latest) { (error, balance) in
            if let balance = balance {
                completion(.success(balance))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(0))
            }
        }
    }
}

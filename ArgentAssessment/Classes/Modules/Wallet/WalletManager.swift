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

enum WalletManagerError: Error {
    case noAccount
    case unexpectedError
}

protocol WalletManagerProtocol {
    func getCurrentBalance(completion: @escaping (Result<BigUInt, Error>) -> Void)
    func createTransaction() throws -> EthereumTransaction
    func sendTransaction(_ transaction: EthereumTransaction, completion: @escaping (Result<String, Error>) -> Void)
    func getTransfersList(completion: @escaping (Result<[ERC20Events.Transfer], Error>) -> Void)
}

class WalletManager {
    
    // MARK: Account vars
    private let keyStorage: EthereumKeyLocalStorage = {
        let storage = EthereumKeyLocalStorage()
        let privateKey: String = "0xec983791a21bea916170ee0aead71ab95c13280656e93ea4124c447bbd9a24a2"
        try? storage.storePrivateKey(key: privateKey.web3.hexData!)
        return storage
    }()
    private lazy var account: EthereumAccount? = {
        try? EthereumAccount(keyStorage: self.keyStorage)
    }()
    
    // MARK: Client vars
    private let clientUrl = URL(string: "https://ropsten.infura.io/v3/735489d9f846491faae7a31e1862d24b")!
    private lazy var client: EthereumClient = EthereumClient(url: clientUrl)
    
    // MARK: Argent
    let argentWalletAddress = EthereumAddress("0x70ABd7F0c9Bdc109b579180B272525880Fb7E0cB")
    let transferManagerModuleAddress = EthereumAddress("0xcdAd167a8A9EAd2DECEdA7c8cC908108b0Cc06D1")
    let transferManagerToken = EthereumAddress("0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE")
    let recipientAddress = EthereumAddress("0x361b7f3ed03d74C6aD3E6923C2a298fC6b741367") // Metamask Account
}

//MARK: - WalletManagerProtocol methods

extension WalletManager: WalletManagerProtocol {

    func getCurrentBalance(completion: @escaping (Result<BigUInt, Error>) -> Void) {
        self.getCurrentBalance(address: argentWalletAddress.value, completion: completion)
    }
    
    func createTransaction() throws -> EthereumTransaction {
        let transferTokenFunction = TransferToken(
            contract: transferManagerModuleAddress,
            from: argentWalletAddress,
            wallet: argentWalletAddress,
            token: transferManagerToken,
            to: recipientAddress
        )
        return try transferTokenFunction.transaction()
    }
    
    func sendTransaction(_ transaction: EthereumTransaction, completion: @escaping (Result<String, Error>) -> Void) {
        guard let account = self.account else { return completion(.failure(WalletManagerError.noAccount)) }
        self.client.eth_sendRawTransaction(transaction, withAccount: account) { (error, txHash) in
            if let txHash = txHash {
                completion(.success(txHash))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(WalletManagerError.unexpectedError))
            }
        }
    }
    
    func getTransfersList(completion: @escaping (Result<[ERC20Events.Transfer], Error>) -> Void) {
        let erc20 = ERC20(client: self.client)
        erc20.transferEventsTo(
        recipient: argentWalletAddress, fromBlock: .Earliest, toBlock: .Latest) { (error, transfers) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(transfers ?? []))
            }
        }
    }
}

//MARK: - Private methods

private extension WalletManager {
    
    func getCurrentBalance(address: String, completion: @escaping (Result<BigUInt, Error>) -> Void) {
        self.client.eth_getBalance(address: address, block: .Latest) { (error, balance) in
            if let balance = balance {
                completion(.success(balance))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(WalletManagerError.unexpectedError))
            }
        }
    }
}

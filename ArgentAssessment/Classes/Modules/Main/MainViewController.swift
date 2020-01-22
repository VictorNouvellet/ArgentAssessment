//
//  MainViewController.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 2/28/19.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import UIKit

protocol MainViewControllerProtocol: class {
    
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var walletBalanceLabel: ArgentLabel!
    
    @IBOutlet weak var sendButton: ArgentButton! {
        didSet { sendButton.setTitle(NSLocalizedString("Send 0.01 ETH", comment: ""), for: UIControl.State()) }
    }
    
    @IBOutlet weak var viewTransfersButton: ArgentButton! {
        didSet { viewTransfersButton.setTitle(NSLocalizedString("View ERC20 Transfers", comment: ""), for: UIControl.State()) }
    }
    
    // MARK: Injected vars
    
    var interactor: MainInteractorProtocol!
    
    // MARK: Private vars
    
    private let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
}

// MARK: View management methods

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.interactor.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor.onViewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sendButton.layer.roundedLayer(10)
    }
}

// MARK: Setup methods

private extension MainViewController {
    
    func setup() {
        self.setupViewModelCallback()
        self.setupWalletBalanceLabelInteraction()
    }
    
    func setupViewModelCallback() {
        self.interactor.callbackModelUpdate = { [weak self] (viewModel) in
            guard let weakSelf = self else { return }
            
            if let walletBalance = viewModel.walletBalance {
                weakSelf.walletBalanceLabel.text = walletBalance
                weakSelf.walletBalanceLabel.hideLoading()
            } else {
                weakSelf.walletBalanceLabel.showLoading()
            }
        }
    }
    
    func setupWalletBalanceLabelInteraction() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(walletBalanceLabelTapped))
        self.walletBalanceLabel.addGestureRecognizer(tapRecognizer)
        self.walletBalanceLabel.isUserInteractionEnabled = true
    }
}

// MARK: Private methods

private extension MainViewController {
    func showAlert(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
}

// MARK: Internal methods

extension MainViewController: MainViewControllerProtocol {
    
    func handleSendReceipt(result: Result<String, Error>) {
        switch result {
        case .failure(let error):
            self.showAlert(title: "Transaction error", message: "Error description: \(error.localizedDescription)")
        case .success(let txHash):
            let title = "Transaction success!"
            let message = "TxHash: \(txHash)"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(defaultAction)
            let copyTxHashAction = UIAlertAction(title: "Copy txHash", style: .default) { _ in
                UIPasteboard.general.string = txHash
            }
            alertController.addAction(copyTxHashAction)
            self.present(alertController, animated: true)
        }
    }
}

// MARK: IBActions & objc methods

extension MainViewController {
    
    @IBAction func sendButtonTapped(_ button: ArgentButton) {
        button.showLoading()
        self.selectionFeedbackGenerator.selectionChanged()
        self.interactor.send(completion: { [weak self] result in
            DispatchQueue.main.async(execute: { [weak self] in
                self?.handleSendReceipt(result: result)
                button.hideLoading()
            })
        })
    }
    
    @IBAction func viewTransfersButtonTapped(_ button: UIButton) {
        guard let transfersListVC = TransfersListBuilder.getView() else { return }
        self.navigationController?.pushViewController(transfersListVC, animated: true)
    }
    
    @objc func walletBalanceLabelTapped() {
        self.interactor.updateBalance()
    }
}

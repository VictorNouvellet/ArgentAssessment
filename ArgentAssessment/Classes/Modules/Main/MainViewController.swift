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
    
    @IBOutlet weak var walletBalanceLabel: UILabel!
    
    @IBOutlet weak var sendButton: UIButton! {
        didSet { sendButton.setTitle(NSLocalizedString("Send 0.01 ETH", comment: ""), for: UIControl.State()) }
    }
    
    @IBOutlet weak var viewTransfersButton: UIButton! {
        didSet { sendButton.setTitle(NSLocalizedString("View ERC20 Transfers", comment: ""), for: UIControl.State()) }
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor.onViewDidAppear()
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
    }
    
    func setupViewModelCallback() {
        self.interactor.callbackModelUpdate = { [weak self] (viewModel) in
            guard let weakSelf = self else { return }
            weakSelf.walletBalanceLabel.text = viewModel.walletBalance
        }
    }
}

// MARK: Private methods

private extension MainViewController {
    
}

// MARK: Internal methods

extension MainViewController: MainViewControllerProtocol {
    
}

// MARK: IBActions & objc methods

extension MainViewController {
    
    @IBAction func sendButtonTapped(_ button: UIButton) {
        self.selectionFeedbackGenerator.selectionChanged()
        self.interactor.send(completion: { [weak self] result in
            print("Save result: \(result)")
        })
    }
}

//
//  TransfersListViewController.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class TransfersListViewController: UIViewController {
    
    //MARK: - Interface Builder vars
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Injected vars
    
    var interactor: TransfersListInteractorInterface!
}

//MARK: - View management methods

extension TransfersListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor.callbackModelUpdate = { [weak self] (viewModel) in
            guard let self = self else { return }
            self.titleLabel.text = viewModel.title
        }
        
        self.setup()
    }
}

//MARK: - Setup methods

extension TransfersListViewController {
    func setup() {

    }
}

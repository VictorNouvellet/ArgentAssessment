//
//  BaseViewController.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {}

// MARK: View management methods

extension BaseViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.launch()
    }
}

// MARK: Private methods

private extension BaseViewController {
    func launch() {
        guard let mainVC = MainBuilder.getView() else { return }
        let navigationVC = UINavigationController(rootViewController: mainVC)
        navigationVC.navigationBar.isTranslucent = true
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: false, completion: nil)
    }
}

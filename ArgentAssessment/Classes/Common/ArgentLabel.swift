//
//  ArgentLabel.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 22/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ArgentLabel: UILabel {
    
    var activityIndicator: UIActivityIndicatorView?
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            if (self.isUserInteractionEnabled) {
                self.textColor = self.textColor.withAlphaComponent(1)
            } else {
                self.textColor = self.textColor.withAlphaComponent(0)
            }
        }
    }
    
    @IBInspectable private var shouldShowLoading: Bool = false {
        didSet {
            self.setup()
        }
    }
    
    func setup() {
        self.activityIndicator?.removeFromSuperview()
        self.activityIndicator = UIActivityIndicatorView.init(frame: CGRect(x: (self.frame.width / 2) - 10, y: (self.frame.height / 2) - 10, width: 20.0, height: 20.0))
        self.activityIndicator?.color = UIColor.label
        self.activityIndicator?.backgroundColor = .clear
        if let ac = self.activityIndicator {
            self.addSubview(ac)
        }
        self.showOrHideLoading()
    }
}

// MARK: - View management methods

extension ArgentLabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
    }

    override func prepareForInterfaceBuilder() {
        self.setup()
    }
}

// MARK: - Internal methods

extension ArgentLabel {
    
    /// Show Loader on Label and hide Label title
    func showLoading() {
        self.shouldShowLoading = true
        self.showOrHideLoading()
    }


    /// Hide Loader on Label and show Label title
    func hideLoading() {
        self.shouldShowLoading = false
        self.showOrHideLoading()
    }
}

// MARK: - Private methods

private extension ArgentLabel {
    
    func showOrHideLoading() {
        if (shouldShowLoading) {
            self.isUserInteractionEnabled = false
            self.activityIndicator?.isHidden = false
            self.activityIndicator?.startAnimating()
        } else {
            self.isUserInteractionEnabled = true
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.isHidden = true
        }
    }

}

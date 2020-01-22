//
//  ArgentButton.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 22/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ArgentButton: UIButton {

    var activityIndicator: UIActivityIndicatorView?
    var titleString: String?

    override var isEnabled: Bool {
        didSet {
            if (self.isEnabled) {
                self.alpha = 1.0
            } else {
                self.alpha = 0.5
            }
        }
    }

    @IBInspectable private var shouldShowLoading: Bool = false {
        didSet {
            self.setup()
        }
    }
}

// MARK: - View management methods

extension ArgentButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupGradient()
        self.setup()
    }

    override func prepareForInterfaceBuilder() {
        self.setupGradient()
        self.setup()
    }
}

// MARK: - Setup methods

private extension ArgentButton {

    func setup() {
          self.activityIndicator?.removeFromSuperview()
          self.activityIndicator = UIActivityIndicatorView.init(frame: CGRect.init(x: (self.frame.width / 2) - 10, y: (self.frame.height / 2) - 10, width: 20.0, height: 20.0))
          self.activityIndicator?.color = UIColor.white
          self.activityIndicator?.backgroundColor = .clear
          if let ac = self.activityIndicator {
              self.addSubview(ac)
          }
          self.showOrHideLoading()
          self.setTitleColor(.white, for: .normal)
          self.setTitleColor(.clear, for: .disabled)
          self.titleLabel?.font = .boldSystemFont(ofSize: 16.0)
      }
}

// MARK: - Internal methods

extension ArgentButton {
    
    /// Show Loader on Button and hide Button title
    func showLoading() {
        self.shouldShowLoading = true
        self.showOrHideLoading()
    }


    /// Hide Loader on Button and show Button title
    func hideLoading() {
        self.shouldShowLoading = false
        self.showOrHideLoading()
    }
}

// MARK: - Private methods

private extension ArgentButton {
    
    func setupGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.main.cgColor, UIColor.main.withAlphaComponent(0.9).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = self.frame.height / 2
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func showOrHideLoading() {
        if (shouldShowLoading) {
            self.isEnabled = false
            self.activityIndicator?.isHidden = false
            self.activityIndicator?.startAnimating()
        } else {
            self.isEnabled = true
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.isHidden = true
        }
    }

}

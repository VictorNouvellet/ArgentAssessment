//
//  CALayer+Rounded.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import UIKit

extension CALayer {
    func roundedLayer(_ cornerRadius: CGFloat? = nil) {
        self.cornerRadius = cornerRadius ?? self.bounds.size.height / 2
        self.masksToBounds = true
    }
}

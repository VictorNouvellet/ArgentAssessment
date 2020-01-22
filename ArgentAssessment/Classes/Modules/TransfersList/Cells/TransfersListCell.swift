//
//  TransfersListCell.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import UIKit

final class TransfersListCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    // MARK: Internal methods
    
    func configure(withFromAddress from: String, token: String, amount: String) {
        self.fromLabel.text = from
        self.tokenLabel.text = token
        self.amountLabel.text = amount
    }
}

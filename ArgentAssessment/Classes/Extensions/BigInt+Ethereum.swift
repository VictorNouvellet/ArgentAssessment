//
//  BigInt+Ethereum.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import BigInt

extension BigUInt {
    func weiToEther(decimals: Int = 2) -> Double {
        let divisor = BigUInt(10).power(18 - decimals)
        let numerator = Double(self) / Double(divisor)
        return numerator.rounded() / pow(10.0, Double(decimals))
    }
}

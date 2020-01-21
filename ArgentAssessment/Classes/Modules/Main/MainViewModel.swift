//
//  MainViewModel.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct MainViewModel {
    let walletBalance: String
    
    init(walletBalance: String)   {
        self.walletBalance = walletBalance
    }
    
    static func defaultModel() -> MainViewModel {
        return MainViewModel(walletBalance: "0 ETH".localizedUppercase)
    }
}

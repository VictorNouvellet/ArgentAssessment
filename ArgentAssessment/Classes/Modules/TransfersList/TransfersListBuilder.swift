//
//  TransfersListBuilder.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class TransfersListBuilder {
    
    static let name = "TransfersList"
    
    static var storyboard: UIStoryboard { return UIStoryboard(name: self.name, bundle: Bundle.main) }
    
    static func getView() -> TransfersListViewController? {
        let view = self.storyboard.instantiateInitialViewController() as? TransfersListViewController
        let interactor = TransfersListInteractor()
        interactor.view = view
        view?.interactor = interactor
        return view
    }
}

//
//  TransfersListViewController.swift
//  ArgentAssessment
//
//  Created by Victor Nouvellet on 21/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

protocol TransfersListViewControllerProtocol: class { }

final class TransfersListViewController: UIViewController, TransfersListViewControllerProtocol {
    
    enum Section: CaseIterable {
        case main
    }
    
    //MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Injected vars
    
    var interactor: TransfersListInteractorProtocol!
    
    // MARK: Private vars
    
    var dataSource: UICollectionViewDiffableDataSource<Section, TransfersListTransferViewModel>!
}

//MARK: - View management methods

extension TransfersListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("ERC20 Transfers", comment: "")
        
        self.interactor.callbackModelUpdate = { [weak self] (viewModel) in
            guard let self = self else { return }
            self.updateCollectionView(with: viewModel.transfersList)
        }
        
        self.setup()
        self.interactor.onViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor.onViewDidAppear {
            DispatchQueue.main.async(execute: { [weak self] in
                self?.collectionView.refreshControl?.endRefreshing()
            })
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

//MARK: - Setup methods

private extension TransfersListViewController {
    
    func setup() {
        self.setupCollectionView()
        self.setupRefreshControl()
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.dataSource = UICollectionViewDiffableDataSource<Section, TransfersListTransferViewModel>(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell: TransfersListCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withFromAddress: model.fromAddress, token: model.token, amount: model.amount)
            return cell
        }
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(manualRefreshTriggered), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.refreshControl = refreshControl
    }
}


//MARK: - Internal methods

extension TransfersListViewController {
    
    func updateCollectionView(with transfers: [TransfersListTransferViewModel]?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TransfersListTransferViewModel>()
        if let transfers = transfers {
            snapshot.appendSections([.main])
            snapshot.appendItems(transfers, toSection: .main)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func manualRefreshTriggered() {
        self.interactor.onTransfersListManualRefresh {
            DispatchQueue.main.async(execute: { [weak self] in
                self?.collectionView.refreshControl?.endRefreshing()
            })
        }
    }
}

//MARK: - UICollectionViewFlowLayout methods

extension TransfersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kHeight = 110
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kHeight))
    }
}

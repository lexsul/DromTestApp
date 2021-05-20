//
//  ImageViewerImageViewerPresenter.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07/05/2021.
//  Copyright © 2021 alex. All rights reserved.
//
import UIKit

class ImageViewerPresenter: ImageViewerInteractorOutput {

    // MARK: Public Properties
    
    weak var view: ImageViewerViewInput!
    var interactor: ImageViewerInteractorInput!
    var router: ImageViewerRouterInput!
    var output: ImageViewerModuleOutput?

}

// MARK: - ImageViewerViewOutput

extension ImageViewerPresenter: ImageViewerViewOutput {

    func viewDidLoad() {
        interactor.getImageURLList { [weak self] (urlList) in
            self?.view.setupInitialState(model: urlList)
        }
    }
    
    func refreshData() {
        interactor.cleanImageCache()
        interactor.getImageURLList { [weak self] (urlList) in
            self?.view.refreshData(model: urlList)
        }
    }

}

// MARK: - ImageCollectionViewCellDelegate

extension ImageViewerPresenter: ImageCollectionViewCellDelegate {
    func loadImageFrom(stringURL: String, completion: @escaping (UIImage) -> Void) {
        interactor.loadImageFrom(stringURL: stringURL, completion: completion)
    }
}

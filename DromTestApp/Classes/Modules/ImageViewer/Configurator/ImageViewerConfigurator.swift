//
//  ImageViewerImageViewerConfigurator.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07/05/2021.
//  Copyright © 2021 alex. All rights reserved.
//

import UIKit

class ImageViewerModuleConfigurator {

  func configure(output: ImageViewerModuleOutput?) -> UIViewController {
        
        let viewController = ImageViewerViewController()

        let router = ImageViewerRouter()
        router.view = viewController

        let presenter = ImageViewerPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.output = output

        let interactor = ImageViewerInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }
}

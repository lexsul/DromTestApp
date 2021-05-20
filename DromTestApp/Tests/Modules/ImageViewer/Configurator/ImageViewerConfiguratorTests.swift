//
//  ImageViewerImageViewerConfiguratorTests.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07/05/2021.
//  Copyright © 2021 alex. All rights reserved.
//

import XCTest

class ImageViewerModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = ImageViewerViewControllerMock()
        let configurator = ImageViewerModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "ImageViewerViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ImageViewerPresenter, "output is not ImageViewerPresenter")

        let presenter: ImageViewerPresenter = viewController.output as! ImageViewerPresenter
        XCTAssertNotNil(presenter.view, "view in ImageViewerPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ImageViewerPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ImageViewerRouter, "router is not ImageViewerRouter")

        let interactor: ImageViewerInteractor = presenter.interactor as! ImageViewerInteractor
        XCTAssertNotNil(interactor.output, "output in ImageViewerInteractor is nil after configuration")
    }

    class ImageViewerViewControllerMock: ImageViewerViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}

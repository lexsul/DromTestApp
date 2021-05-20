//
//  ImageViewerImageViewerViewInput.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07/05/2021.
//  Copyright © 2021 alex. All rights reserved.
//

protocol ImageViewerViewInput: class {

    func setupInitialState(model: [String])
    func refreshData(model: [String])
    
}

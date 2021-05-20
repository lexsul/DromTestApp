//
//  ImageViewerImageViewerInteractorInput.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07/05/2021.
//  Copyright © 2021 alex. All rights reserved.
//

import UIKit

protocol ImageViewerInteractorInput {
    func cleanImageCache()
    func loadImageFrom(stringURL: String, completion: @escaping (UIImage) -> Void)
    func getImageURLList(completion: @escaping ([String]) -> Void)
}

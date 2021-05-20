//
//  ImageViewerImageViewerInteractor.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07/05/2021.
//  Copyright © 2021 alex. All rights reserved.
//

import UIKit

class ImageViewerInteractor {

    // MARK: - Public Properties
    
    weak var output: ImageViewerInteractorOutput!

    // MARK: Private Properties
    
    private let cache = ImageCache()
    
    // MARK: - ImageViewerInteractorInput
    
}

// MARK: - ImageViewerInteractorInput

extension ImageViewerInteractor: ImageViewerInteractorInput {
    func cleanImageCache() {
        cache.removeAllImages()
    }
    
    func getImageURLList(completion: @escaping ([String]) -> Void) {
        completion(["https://source.unsplash.com/category/nature",
                    "https://loremflickr.com/640/360",
                    "https://placebear.com/640/360",
                    "https://placebeard.it/640x360",
                    "https://picsum.photos/640/360",
                    "https://www.stevensegallery.com/640/360"
                    
        ])
    }
    
    func loadImageFrom(stringURL: String, completion: @escaping (_ image: UIImage) -> Void) {
        guard !stringURL.isEmpty else {
            NSLog("Image string URL is empty")
            return
        }
        
        guard let url = URL(string: stringURL) else {
            NSLog("Could not form valid URL from: \(stringURL)")
            return
        }
        
        if let image = cache[url] {
            completion(image)
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, _, error) in
                if error != nil {
                    NSLog("Image is nil")
                    return
                } else if let data = data {
                    DispatchQueue.main.async {
                        guard let image = UIImage(data: data) else { return }
                        self?.cache[url] = image
                        completion(image)
                    }
                }
            }).resume()
        }
    }
}

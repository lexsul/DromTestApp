//
//  ImageCollectionViewCell.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07.05.2021.
//

import UIKit

protocol ImageCollectionViewCellDelegate: class {
    func loadImageFrom(stringURL: String, completion: @escaping (UIImage) -> Void)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    private weak var imageView: UIImageView?
    private weak var delegate: ImageCollectionViewCellDelegate?
    
    override func draw(_ rect: CGRect) {
        let imageView = UIImageView(frame: self.contentView.frame)
        self.contentView.backgroundColor = .green
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imageView = imageView
    }
    
    func setup(model: String, delegate: ImageCollectionViewCellDelegate?) {
        delegate?.loadImageFrom(stringURL: model, completion: {[weak self] (image) in
            self?.imageView?.image = image
        })
    }
}

//
//  ImageViewerImageViewerViewController.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07/05/2021.
//  Copyright © 2021 alex. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController, ModuleTransitionable {
    
    // MARK: - Public Properties

    var output: ImageViewerViewOutput!
    
    // MARK: Private Properties
    
    private weak var collectionView: UICollectionView?
    private var refreshControl = UIRefreshControl()
    private var model: [String] = []

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output.viewDidLoad()
    }
    
    private func setupUI() {
        setupCollectionView()
        setupRefreshControll()
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = CustomCollectionViewFlowLayout()
    
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        view.addSubview(collectionView)
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.backgroundColor = .blue
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView = collectionView
    }
    
    private func setupRefreshControll() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView?.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        output.refreshData()
    }
}

// MARK: -  UICollectionViewDelegate

extension ImageViewerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [indexPath])
            model.remove(at: indexPath.item)
        } completion: { _ in }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImageViewerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 10,
                      height: view.bounds.width - 10)
    }
}

// MARK: -  UICollectionViewDataSource

extension ImageViewerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath)
        
        if let cell = cell as? ImageCollectionViewCell {
            cell.setup(model: model[indexPath.row], delegate: output)
        }
        
        return cell
    }
    
    
}

// MARK: ImageViewerViewInput

extension ImageViewerViewController: ImageViewerViewInput {

    func setupInitialState(model: [String]) {
        self.model = model
        self.collectionView?.reloadData()
    }
    
    func refreshData(model: [String]) {
        setupInitialState(model: model)
        refreshControl.endRefreshing()
    }
}

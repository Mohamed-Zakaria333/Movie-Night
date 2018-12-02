//
//  HomeCollectionCell.swift
//  Movie Night
//
//  Created by Youssef Mostafa on 11/30/18.
//  Copyright © 2018 UsefDev. All rights reserved.
//

import UIKit

class HomeCollectionCell: MNCollectionViewCell {
    
    var dataSource: Movie? {
        willSet {
            if let newValue = newValue {
                contentRate.text = "\(newValue.rate ?? 0)"
                contentTitle.text = "\(newValue.title ?? "")"
                if newValue.posterPath != nil {
                    let url = APIManager.createPhotoUrl(from: newValue.posterPath!)
                    
                    contentImageView.sd_setImage(with: url, placeholderImage: nil, options: .progressiveDownload, progress: nil, completed: nil)
                }
            }
        }
    }
    
    // MARK: - Views
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let contentRate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.rgb(74, 74, 74, 0.9)
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    private let contentTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.layer.opacity = 0.95
        label.backgroundColor = .clear
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    // MARK: - LifeCycle Methods
    
    override func setupUI() {
        clipsToBounds = true
        backgroundColor = .white
    }
    
    override func setupSubViews() {
        addSubview(contentImageView)
        addSubview(contentRate)
        addSubview(contentTitle)
    }
    
    override func setupConstraints() {
        contentImageView.edgesToSuperView(exclude: .bottom)
        contentImageView.setHeight(360)
        
        contentRate.anchorTop(topAnchor, padding: 8)
        contentRate.anchorLeading(leadingAnchor, padding: 8)
        contentRate.set(width: 44, height: 20)
        
        contentTitle.edgesToSuperLeadingAndTrailing()
        contentTitle.anchorTop(contentImageView.bottomAnchor, padding: 8)
    }
    
    
}

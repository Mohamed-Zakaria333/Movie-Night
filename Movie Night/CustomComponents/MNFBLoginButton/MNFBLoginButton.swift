//
//  MNFBLoginButton.swift
//  Movie Night
//
//  Created by Youssef Mostafa on 11/6/18.
//  Copyright © 2018 UsefDev. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class MNFBLoginButton: MNButton {
    
    // MARK: - Delegate
    
    var delegate: MNFBLoginButtonDelegate? 
    
    // MARK: - Views
    
    private let fbImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "FaceBookIcon"))
        return imageView
    }()
    
    // MARK: - Main Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupSubViews()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Methods
    
    private func setupActions() {
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    private func setupUI() {
        backgroundColor = UIColor.rgb(59, 89, 152)
        layer.cornerRadius = 2
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        layer.masksToBounds = true
        tintColor = .white
        setTitle("Signup with Facebook", for: .normal)
    }
    
    private func setupSubViews() {
        addSubview(fbImageView)
    }
    
    @objc private func didTap() {
        guard let delegate = delegate else { return }
        delegate.loadingViewStartedAnimation()
        FaceBookManager.login(delegate as! UIViewController) { (userInfo, error) in
            if let error = error {
                print(error.localizedDescription)
                delegate.loadingViewStopedAnimation()
                return
            }
            guard let userInfo = userInfo else {
                delegate.loadingViewStopedAnimation()
                return
            }
            delegate.loginSuccessed(with: userInfo)
        }
    }
    
    private func setupConstraints() {
        fbImageView.edgesToSuperView(exclude: .trailing, width: 36)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

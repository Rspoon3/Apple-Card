//
//  TransactionDetailsVC.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TransactionDetailsVC: UIViewController {
    
    lazy var phoneBarButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: -5, y: -5, width: 40, height: 40)
        button.addSubview(blurredEffectView)
        
        let imageView = UIImageView()
        if let myImage = UIImage(named: "phone") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintableImage
            imageView.tintColor = .white
        }
        imageView.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        return button
    }()
    
    lazy var infoCirleButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: -5, y: -5, width: 40, height: 40)
        button.addSubview(blurredEffectView)
        
        let imageView = UIImageView()
        if let myImage = UIImage(named: "infoCircle") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintableImage
            imageView.tintColor = .white
        }
        imageView.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        return button
    }()
    
    var transaction: Transaction!

    override func viewDidLoad() {
        super.viewDidLoad()
        let phoneBarButtonItem : UIBarButtonItem = .init(customView: phoneBarButton)
        let infoCirleButtonItem : UIBarButtonItem = .init(customView: infoCirleButton)

        view.backgroundColor = .bgColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItems = [infoCirleButtonItem, phoneBarButtonItem]
        
        let bottomView = BottomView(frame: view.frame, amount: transaction.price)
        let tableView = TransactionMapTableView(frame: view.frame, style: .plain, transaction: transaction)
        let heroImage = HeroImageView(frame: view.frame, transaction: transaction)
        [heroImage, tableView, bottomView].forEach({view.addSubview($0)})
        
        let constriants = [
            heroImage.topAnchor.constraint(equalTo: view.topAnchor),
            heroImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/4)),
            heroImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 50),
            tableView.heightAnchor.constraint(equalToConstant: 324),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/6)),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constriants)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = view.tintColor
    }
}

//
//  TransactionDetailsVC.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit
import SafariServices

class TransactionDetailsVC: UIViewController, SFSafariViewControllerDelegate{
    
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
            let tintableImage = myImage.withRenderingMode(.alwaysOriginal)
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(getMoreInfo))
        tap.numberOfTapsRequired = 1
        
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: -5, y: -5, width: 40, height: 40)
        blurredEffectView.addGestureRecognizer(tap)
        button.addSubview(blurredEffectView)
        
        let imageView = UIImageView()
        if let myImage = UIImage(named: "infoCircle") {
            let tintableImage = myImage.withRenderingMode(.alwaysOriginal)
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
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItems = [infoCirleButtonItem, phoneBarButtonItem]
        
        let bottomView = BottomView(frame: view.frame, amount: transaction.price)
        let mapTableView = TransactionMapTableView(frame: view.frame, style: .plain, transaction: transaction)
        let heroImage = HeroImageView(frame: view.frame, transaction: transaction)
        let transactionHistoryTableView = TransactionHistoryTableView(frame: view.frame, style: .plain, transaction: transaction)
        let tableStackView = TableStackView(frame: view.frame, table: transactionHistoryTableView, title: "Transaction History")
        let scrollView = UIScrollView(frame: .zero)
        let tableViewHeight : CGFloat = 105
        let mapTableViewHeight = view.frame.height * 0.2
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(scrollView)
        
        let containerView = UIView()
        containerView.frame = view.bounds
        scrollView.addSubview(containerView)
        
        view.addSubview(heroImage)
        [mapTableView, tableStackView, bottomView].forEach({containerView.addSubview($0)})
        
        let constriants = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            heroImage.topAnchor.constraint(equalTo: view.topAnchor),
            heroImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/4)),
            heroImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mapTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: mapTableViewHeight),
            mapTableView.heightAnchor.constraint(equalToConstant: 324),
            mapTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mapTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            tableStackView.topAnchor.constraint(equalTo: mapTableView.bottomAnchor, constant: 20),
            tableStackView.heightAnchor.constraint(equalToConstant: tableViewHeight),
            tableStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            bottomView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: (1/6)),
            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constriants)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = view.tintColor
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func getMoreInfo(){
        let searchTerm = transaction.title
        let newString = searchTerm.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        var urlString = "http://www.google.com/search?q=" + (newString)
        
        if let city = transaction.city{
            if let state = transaction.state{
                urlString += "+\(city),+\(state)"
            }
        }
        
        let url = NSURL(string: urlString)! as URL
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}

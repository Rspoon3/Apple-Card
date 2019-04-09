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
    
    lazy var phoneBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.roundCorners(radius: 15)
        
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
    
    var totalPrice = 0.0
    
    lazy var infoCirleButton : UIButton = {
        let button = UIButton(type: .system)
        let tap = UITapGestureRecognizer(target: self, action: #selector(getMoreInfo))
        tap.numberOfTapsRequired = 1
        
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.roundCorners(radius: 15)
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: -5, y: -5, width: 40, height: 40)
        blurredEffectView.addGestureRecognizer(tap)
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
    let scrollView = UIScrollView()
    lazy var bottomView = BottomView(frame: view.frame)


    lazy var transactionHistoryTableView = TransactionHistoryTableView(frame: view.frame, style: .plain, transaction: transaction)

    override func viewDidLoad() {
        super.viewDidLoad()
        let phoneBarButtonItem : UIBarButtonItem = .init(customView: phoneBarButton)
        let infoCirleButtonItem : UIBarButtonItem = .init(customView: infoCirleButton)
        bottomView.text = "Total This Month"
        bottomView.amount = transaction.price
        transactionHistoryTableView.hisotryDelegate = self
        
        view.backgroundColor = .bgColor
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItems = [infoCirleButtonItem, phoneBarButtonItem]
        
        let mapTableView = TransactionMapTableView(frame: view.frame, style: .plain, transaction: transaction)
        let heroImage = HeroImageView(frame: view.frame, transaction: transaction)
        let sidePadding : CGFloat = 20
        view.addSubview(scrollView)
        view.addSubview(heroImage)
        view.addSubview(bottomView)
        
        [mapTableView, transactionHistoryTableView].forEach({scrollView.addSubview($0)})
        
        scrollView.anchor(top: heroImage.bottomAnchor, bottom: bottomView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        mapTableView.anchor(top: scrollView.topAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, constant: .init(top: sidePadding, left: sidePadding, bottom: 0, right: sidePadding), size: CGSize(width: view.frame.width - 2 * sidePadding, height: view.frame.height * 0.39))
    
        
        transactionHistoryTableView.anchor(top: mapTableView.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, constant: .init(top: sidePadding, left: sidePadding, bottom: 0, right: sidePadding))
       
        
        bottomView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: view.frame.height * (1/6)))
        
        heroImage.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: view.frame.height * 0.25))
    
    }
    
    override func viewWillLayoutSubviews() {
        let tableHeight = 44.0 * 1.9 * CGFloat(3)
        transactionHistoryTableView.anchor(top: nil, bottom: scrollView.bottomAnchor, leading: nil, trailing: nil, size: CGSize(width: 0, height: tableHeight))
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


extension TransactionDetailsVC: TransactionHistoryTableViewDelgate{
    func updateTotalAmount(price: Double) {
        totalPrice += price
        bottomView.amount = totalPrice
    }
}




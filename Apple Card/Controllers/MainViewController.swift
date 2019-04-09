//
//  MainViewController().swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

//Intern screen
class MainViewController: UIViewController, TransactionCellDelegate{

    let transactions = [
        Transaction(title: "Goodman Theatre", city: "Chicago", state: "IL", date: "Yesterday", price: 48.67, logo: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.35 AM"), heroImage: #imageLiteral(resourceName: "Screen Shot 2019-04-05 at 10.36.57 PM"), category: "ENTERTAINMENT"),
        Transaction(title: "Whirlyball", city: "Chicago", state: "IL", date: "3 days ago", price: 42.88, logo: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.42 AM") , heroImage: #imageLiteral(resourceName: "Image"), category: "ENTERTAINMENT"),
        Transaction(title: "Game Room", city: "Chicago", state: "IL", date: "6 days ago", price: 45.71, logo: #imageLiteral(resourceName: "Entertainment"), heroImage: #imageLiteral(resourceName: "Image-1"), category: "ENTERTAINMENT"),
        Transaction(title: "The Second City", city: "Chicago", state: "IL", date: "3/16/19", price: 52.64, logo: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.50 AM"), heroImage: #imageLiteral(resourceName: "Image-2"), category: "ENTERTAINMENT"),
        Transaction(title: "Fandango", city: nil, state: nil, date: "3/9/19", price: 29.80, logo: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.58 AM"), heroImage: #imageLiteral(resourceName: "Image-3"), category: "MOVIES"),
        Transaction(title: "Shell", city: "Chicago", state: "IL", date: "3/2/19", price: 38.67, logo: #imageLiteral(resourceName: "Image-11"), heroImage: #imageLiteral(resourceName: "Image-7"), category: "GAS"),
        Transaction(title: "Wegmans", city: "Chicago", state: "IL", date: "3/2/19", price: 242.88, logo: #imageLiteral(resourceName: "Image-8"), heroImage: #imageLiteral(resourceName: "Image-5"), category: "GROCERYS"),
        Transaction(title: "Wendys", city: "Chicago", state: "IL", date: "3/1/19", price: 15.35, logo: #imageLiteral(resourceName: "Image-9"),heroImage: #imageLiteral(resourceName: "Image-4"), category: "FOOD & DRINK"),
        Transaction(title: "Macys", city: "Chicago", state: "IL", date: "3/1/19", price: 152.64, logo: #imageLiteral(resourceName: "Image-10"), heroImage: #imageLiteral(resourceName: "Image-6"), category: "CLOTHING"),
    ]
    
    lazy var containerHeaderView : UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerImageView)
        let constraints = [
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        NSLayoutConstraint.activate(constraints)
        return view
    }()
    
    let headerImageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "theCard")
        view.roundCorners(radius: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var custuomBarButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.backgroundColor = .black
        button.roundCorners(radius: 15)
        button.addTarget(self, action: #selector(actionSheet), for: .touchUpInside)
        
        let imageView = UIImageView()
        if let myImage = UIImage(named: "3dots") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate) //has to be alwaysTemplate 
            imageView.image = tintableImage
            imageView.tintColor = .white
        }
        imageView.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        return button
    }()
    
    lazy var tableView = TransactionTableView(frame: view.frame, style: .plain, transactions: transactions, sectionName: "Latest Transactions", dailyCashPercentageIsHidden: false)
    lazy var miniViewsStack = MainPaymentStackView() //the three charts
    let scrollView = UIScrollView()
    
    fileprivate func setupNavigationItem(){
        navigationItem.rightBarButtonItem = .init(customView: custuomBarButton)
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    fileprivate func addViewsAndConstraints(_ sidePadding: CGFloat) {
        self.view.addSubview(scrollView)
        scrollView.fillSafeSuperview(safeTop: true, safeBottom: false, safeLeading: false, safeTrialing: false)
        
        [containerHeaderView, miniViewsStack, tableView].forEach({scrollView.addSubview($0)})
        
        containerHeaderView.anchor(top: scrollView.topAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, constant: .init(top: 10, left: sidePadding, bottom: 0, right: 0))
        containerHeaderView.anchorHegihtWidth(height: view.heightAnchor, heightConstant: nil, heightMulitplier: 0.25, width: scrollView.widthAnchor, widthConstant: -sidePadding * 2 , widthMulitplier: nil)
        
        miniViewsStack.anchor(top: containerHeaderView.bottomAnchor, bottom: nil, leading: containerHeaderView.leadingAnchor, trailing: scrollView.trailingAnchor, constant: .init(top: 20, left: 0, bottom: 0, right: 0))
        miniViewsStack.anchorHegihtWidth(height: scrollView.heightAnchor, heightConstant: nil, heightMulitplier: 0.2, width: nil, widthConstant: nil, widthMulitplier: nil)
        
        tableView.anchor(top: miniViewsStack.bottomAnchor, bottom: nil, leading: containerHeaderView.leadingAnchor, trailing: scrollView.trailingAnchor, constant: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    override func viewDidLoad() {
        let sidePadding : CGFloat = 20
        super.viewDidLoad()
        view.backgroundColor = UIColor.bgColor
        NotificationCenter.default.addObserver(self, selector: #selector(payButtonPressed), name: NSNotification.Name(rawValue: "payFromMainScreen"), object: nil)
        setupNavigationItem()
        tableView.mydelegate = self
        addViewsAndConstraints(sidePadding)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentSpendingVC))
        tap.numberOfTapsRequired = 1
        miniViewsStack.smallChartView.addGestureRecognizer(tap)
    }
    
    @objc func presentSpendingVC(){
        let desitinationVC = SpendingViewController()
        desitinationVC.mainTransactions = transactions
        self.navigationController?.pushViewController(desitinationVC, animated: true)
    }

    override func viewWillLayoutSubviews() {
        let tableHeight = 44.0 * 1.9 * CGFloat(transactions.count) + 45
        tableView.anchor(top: nil, bottom: scrollView.bottomAnchor, leading: nil, trailing: nil, size: CGSize(width: 0, height: tableHeight))
    }

    @objc func push(){
        self.navigationController?.pushViewController(CategoryController(), animated: true)
    }
    
    func push(indexPath: IndexPath) {
        let destinationVC = TransactionDetailsVC()
        destinationVC.transaction = transactions[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func actionSheet(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let dailyCash = UIAlertAction(title: "Daily Cash", style: .default) { action in
            let vc = DailyCashController()
            vc.transactions = self.transactions
            vc.bottomTitle = "Total This Month"
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let categories = UIAlertAction(title: "Categories", style: .default) { action in
            let vc = CategoryController()
            vc.transactions = self.transactions
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let support = UIAlertAction(title: "Support", style: .default) { action in
            self.navigationController?.pushViewController(CardInfoViewController(), animated: true)
        }

        actionSheet.addAction(dailyCash)
        actionSheet.addAction(categories)
        actionSheet.addAction(support)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true, completion: nil)
        actionSheet.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
            return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
            }.first?.isActive = false
    }
}


extension MainViewController{
    @objc func payButtonPressed() {
        present(PaymentViewController(), animated: true, completion: nil)
    }
}

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
        Transaction(title: "Goodman Theatre", city: "Chicago", state: "IL", date: "Yesterday", price: 48.67, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.35 AM")),
        Transaction(title: "Whirlyball", city: "Chicago", state: "IL", date: "3 days ago", price: 42.88, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.42 AM")),
        Transaction(title: "Game Room", city: "Chicago", state: "IL", date: "6 days ago", price: 45.71, image: #imageLiteral(resourceName: "Entertainment")),
        Transaction(title: "The Second City", city: "Chicago", state: "IL", date: "3/16/19", price: 52.64, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.50 AM")),
        Transaction(title: "Fandango", city: nil, state: nil, date: "3/9/19", price: 29.80, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.58 AM")),
        
        Transaction(title: "Goodman Theatre", city: "Chicago", state: "IL", date: "Yesterday", price: 48.67, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.35 AM")),
        Transaction(title: "Whirlyball", city: "Chicago", state: "IL", date: "3 days ago", price: 42.88, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.42 AM")),
        Transaction(title: "Fandango", city: nil, state: nil, date: "3/9/19", price: 29.80, image: #imageLiteral(resourceName: "Entertainment")),
        Transaction(title: "The Second City", city: "Chicago", state: "IL", date: "3/16/19", price: 52.64, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.50 AM")),
    ]
    
    func push(indexPath: IndexPath) {
        let destinationVC = TransactionDetailsVC()
        destinationVC.transaction = transactions[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
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
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var custuomBarButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
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
    
    lazy var tableView = TransactionTableView(frame: view.frame, style: .plain, transactions: transactions)
    lazy var tableStackView = TableStackView(frame: view.frame, table: tableView, title: "Latest Transactions")
    lazy var miniViewsStack = MainPaymentStackView() //the three charts
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        let sidePadding : CGFloat = 20
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(actionSheet), name: NSNotification.Name(rawValue: "actionSheet"), object: nil)
        navigationItem.rightBarButtonItem = .init(customView: custuomBarButton)
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
        view.backgroundColor = UIColor.bgColor
        tableView.mydelegate = self
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)

        [containerHeaderView, miniViewsStack, tableStackView].forEach({scrollView.addSubview($0)})
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerHeaderView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            containerHeaderView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -sidePadding * 2),
            containerHeaderView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: sidePadding),
            containerHeaderView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -sidePadding),
            containerHeaderView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.25),

            miniViewsStack.topAnchor.constraint(equalTo: containerHeaderView.bottomAnchor, constant: 20),
            miniViewsStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -sidePadding * 2),
            miniViewsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: sidePadding),
            miniViewsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -sidePadding),
            miniViewsStack.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.2),

            tableStackView.topAnchor.constraint(equalTo: miniViewsStack.bottomAnchor, constant: 30),
            tableStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: sidePadding),
            tableStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -sidePadding),
            tableStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -sidePadding * 2),
        ])

    }

    override func viewWillLayoutSubviews() {
        let tableHeight = 44.0 * 1.9 * CGFloat(transactions.count) + 36
        tableStackView.heightAnchor.constraint(equalToConstant: tableHeight).isActive = true
        tableStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    @objc func push(){
        self.navigationController?.pushViewController(CategoryController(), animated: true)
    }
    
    @objc func actionSheet(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let dailyCash = UIAlertAction(title: "Daily Cash", style: .default) { action in
            self.navigationController?.pushViewController(DailyCashController(), animated: true)
        }

        let categories = UIAlertAction(title: "Categories", style: .default) { action in
            self.navigationController?.pushViewController(CategoryController(), animated: true)
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

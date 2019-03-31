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
        Transaction(title: "Fandango", city: nil, state: nil, date: "3/9/19", price: 29.80, image: #imageLiteral(resourceName: "Screen Shot 2019-03-30 at 2.38.58 AM")),
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
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintableImage
            imageView.tintColor = .white
        }
        imageView.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(actionSheet), name: NSNotification.Name(rawValue: "actionSheet"), object: nil)
        navigationItem.rightBarButtonItem = .init(customView: custuomBarButton)
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
        let tableView = TransactionTableView(frame: view.frame, style: .plain, transactions: transactions)
        let tableStackView = TableStackView(frame: view.frame, table: tableView, title: "Latest Transactions")
        let stack = MainPaymentStackView()
        let scrollView = UIScrollView(frame: .zero)
        let tableViewHeight : CGFloat = (CGFloat(transactions.count) * 1.99 * 44.0)
        
        tableView.mydelegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 350)
        view.addSubview(scrollView)
        
        let containerView = UIView()
        containerView.frame = view.bounds
        scrollView.addSubview(containerView)
        
        [containerHeaderView, stack, tableStackView].forEach({containerView.addSubview($0)})
        view.backgroundColor = UIColor.bgColor
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerHeaderView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10),
            containerHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            containerHeaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            containerHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),

            stack.topAnchor.constraint(equalTo: containerHeaderView.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -20),
            stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

            tableStackView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            tableStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            tableStackView.heightAnchor.constraint(equalToConstant: tableViewHeight),
        ]
        NSLayoutConstraint.activate(constraints)
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

        actionSheet.addAction(dailyCash)
        actionSheet.addAction(categories)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true, completion: nil)
        actionSheet.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
            return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
            }.first?.isActive = false
    }
}

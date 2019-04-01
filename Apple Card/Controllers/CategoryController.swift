//
//  CategoryController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/29/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class CategoryController: UIViewController, TransactionCellDelegate  {
    
    let transactions = [
        Transaction(title: "Goodman Theatre", city: "Chicago", state: "IL", date: "Yesterday", price: 48.67, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Whirlyball", city: "Chicago", state: "IL", date: "3 days ago", price: 42.88, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Game Room", city: "Chicago", state: "IL", date: "6 days ago", price: 45.71, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "The Second City", city: "Chicago", state: "IL", date: "3/16/19", price: 52.64, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Fandango", city: nil, state: nil, date: "3/9/19", price: 29.80, image: #imageLiteral(resourceName: "dailyCash")),

        Transaction(title: "Goodman Theatre", city: "Chicago", state: "IL", date: "Yesterday", price: 48.67, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Whirlyball", city: "Chicago", state: "IL", date: "3 days ago", price: 42.88, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Fandango", city: nil, state: nil, date: "3/9/19", price: 29.80, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "The Second City", city: "Chicago", state: "IL", date: "3/16/19", price: 52.64, image: #imageLiteral(resourceName: "dailyCash")),
    ]
    
    func push(indexPath: IndexPath) {
        let destinationVC = TransactionDetailsVC()
        destinationVC.transaction = transactions[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let totalPrice = transactions.reduce(0, {$0 + $1.price})
        let tableView = TransactionTableView(frame: view.frame, style: .plain, transactions: transactions)
        let headerView = HeaderView(frame: view.frame, image: #imageLiteral(resourceName: "Entertainment"), title: "Entertainment", subTitle: "\(transactions.count) Transactions")
        let bottomView = BottomView(frame: view.frame, amount: totalPrice)
        let tableStackView = TableStackView(frame: view.frame, table: tableView, title: "March 2019")
        let scrollView = UIScrollView(frame: .zero)
        let tableViewHeight : CGFloat = (CGFloat(transactions.count) * 1.99 * 44.0)
        tableView.mydelegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 210)
        view.addSubview(scrollView)
        
        let containerView = UIView()
        containerView.frame = view.bounds
        scrollView.addSubview(containerView)
        
        [headerView, tableStackView, bottomView].forEach({containerView.addSubview($0)})
        view.backgroundColor = UIColor.bgColor

        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/5.5)),
            
            tableStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            tableStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -20),
            tableStackView.heightAnchor.constraint(equalToConstant: tableViewHeight),

            bottomView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: (1/6)),
            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


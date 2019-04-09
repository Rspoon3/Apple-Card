//
//  CategoryController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/29/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class CategoryController: UIViewController, TransactionCellDelegate  {
    
    var transactions : [Transaction] = []
    
    func push(indexPath: IndexPath) {
        let destinationVC = TransactionDetailsVC()
        destinationVC.transaction = transactions[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    let scrollView = UIScrollView()
    lazy var tableView = TransactionTableView(frame: view.frame, style: .plain, transactions: transactions, sectionName: "March 2019", dailyCashPercentageIsHidden: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        let totalPrice = transactions.reduce(0, {$0 + $1.price})
        let headerView = HeaderView(frame: view.frame, image: #imageLiteral(resourceName: "Entertainment"), title: "Entertainment", subTitle: "\(transactions.count) Transactions")
        let bottomView = BottomView(frame: view.frame)
        let padding : CGFloat = 20

        bottomView.text = "Total This Month"
        bottomView.amount = totalPrice
        tableView.mydelegate = self
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(tableView)
        view.addSubview(bottomView)
        view.backgroundColor = UIColor.bgColor
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: bottomView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        headerView.anchor(top: scrollView.topAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: nil, constant: .init(top: 0, left: padding, bottom: 0, right: padding), size: CGSize(width: view.frame.width - 2 * padding, height: view.frame.height * (1/5.5)))
        
        tableView.anchor(top: headerView.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: nil, constant: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: view.frame.width - 2 * padding, height: 0))
        
        bottomView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: view.frame.height * (1/6)))
    }
    
    override func viewWillLayoutSubviews() {
        let tableHeight = 44.0 * 1.9 * CGFloat(transactions.count) + 45
        tableView.anchor(top: nil, bottom: scrollView.bottomAnchor, leading: nil, trailing: nil, size: CGSize(width: 0, height: tableHeight))
    }
}


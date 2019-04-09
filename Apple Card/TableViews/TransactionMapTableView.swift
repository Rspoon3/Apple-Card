//
//  TransactionMapTableView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TransactionMapTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    let transaction : Transaction!
    
    init(frame: CGRect, style: UITableView.Style, transaction: Transaction) {
        self.transaction = transaction
        super.init(frame: frame, style: .plain)
        roundCorners(radius: 10)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        register(TopTransactionDetailCell.self, forCellReuseIdentifier: TopTransactionDetailCell.cellID)
        register(TransactionDetailMapCell.self, forCellReuseIdentifier: TransactionDetailMapCell.cellID)
        isScrollEnabled = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopTransactionDetailCell.cellID, for: indexPath) as! TopTransactionDetailCell
            cell.transaction = transaction
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionDetailMapCell.cellID, for: indexPath) as!
            TransactionDetailMapCell
            cell.transaction = transaction
            return cell
        default:
            let cell = UITableViewCell()
            if let city = transaction.city{
                cell.textLabel?.text = "\(transaction.title), \(city)"
            } else {
                cell.textLabel?.text = "\(transaction.title)"
            }
            cell.accessoryType = .disclosureIndicator
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            return 220
        default:
            return 44
        }
    }
    
}

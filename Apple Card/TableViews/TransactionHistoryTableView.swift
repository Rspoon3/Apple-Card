//
//  TransactionHistoryTableView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

protocol TransactionHistoryTableViewDelgate {
    func updateTotalAmount(price: Double)
}

class TransactionHistoryTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var transaction : Transaction!
    var hisotryDelegate : TransactionHistoryTableViewDelgate!
    
    init(frame: CGRect, style: UITableView.Style, transaction: Transaction) {
        self.transaction = transaction
        super.init(frame: frame, style: .plain)
        roundCorners(radius: 10)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        register(TransactionHistoryCell.self, forCellReuseIdentifier: TransactionHistoryCell.cellID)
        isScrollEnabled = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionHistoryCell.cellID, for: indexPath) as! TransactionHistoryCell
        if indexPath.row == 0{
            cell.transaction = transaction
            hisotryDelegate.updateTotalAmount(price: transaction!.price)
        } else if indexPath.row == 1{
            transaction.date = "\(Int.random(in: 2...6)) Days Ago"
            transaction.price = transaction.price * 0.75
            cell.dailyCashPercentage.text = "1%"
            cell.transaction = transaction
            hisotryDelegate.updateTotalAmount(price: transaction!.price)
        } else {
            transaction.date = "A Week Ago"
            transaction.price = transaction.price * 0.88
            cell.transaction = transaction
            hisotryDelegate.updateTotalAmount(price: transaction!.price)
        }
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 * 1.9
    }

}


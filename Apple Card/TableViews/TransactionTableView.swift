//
//  TransactionTableView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

//Boss screen
protocol TransactionCellDelegate {
    func push(indexPath : IndexPath)
}

class TransactionTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var mydelegate : TransactionCellDelegate!
    
    let transactions : [Transaction]!
    var sectionName : String!
    
    init(frame: CGRect, style: UITableView.Style, transactions: [Transaction], sectionName: String) {
        self.transactions = transactions
        self.sectionName = sectionName
        super.init(frame: frame, style: .plain)
        roundCorners(radius: 10)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0);
        register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.cellID)
        isScrollEnabled = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.cellID, for: indexPath) as! TransactionCell
        if indexPath.row == 0{
            cell.roundTopCorners(radius: 10)
        }
        cell.transaction = transactions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 * 1.9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mydelegate.push(indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.sizeToFit()
        label.text = sectionName
        backgroundColor = .clear
        return label
    }
    

    
}



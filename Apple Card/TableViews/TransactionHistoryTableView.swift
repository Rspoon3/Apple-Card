//
//  TransactionHistoryTableView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TransactionHistoryTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    let transaction : Transaction!
    
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
        cell.transaction = transaction
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 44 * 1.9
        }
    
}


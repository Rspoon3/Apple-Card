//
//  CardInfoTableView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

protocol PayDelegate {
    func pushToPaymentScreen()
}

class CardInfoTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    let cellID = "CardInfoTableView"
    
    var payDelegate : PayDelegate!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        roundCorners(radius: 10)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        isScrollEnabled = false
        backgroundColor = .bgColor
        register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 2{
            return "View your Apple Card Number, CVV, physical card number, and the Device Account Number."
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Payments"
        case 1:
            return "Credit Line"
        case 2:
            return ""
        default:
            return "Bank Accounts"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        cell.roundCorners(radius: 10)
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                cell.textLabel?.text = "Scheduled Payments"
                cell.detailTextLabel?.text = "None"
                cell.accessoryType = .disclosureIndicator
                cell.roundTopCorners(radius: 10)
            } else{
                cell.textLabel?.text = "Make Payment"
                cell.textLabel?.textColor = self.tintColor
                cell.roundBottomCorners(radius: 10)
            }
        case 1:
            if indexPath.row == 0{
                cell.textLabel?.text = "Credit Limit"
                cell.detailTextLabel?.text = "$10,000.00"
                cell.roundTopCorners(radius: 10)
            } else{
                cell.textLabel?.text = "Avaliable Credit"
                cell.detailTextLabel?.text = "$8,317.45"
                cell.roundBottomCorners(radius: 10)
            }
        case 2:
            cell.textLabel?.text = "Card Infromation"
            cell.accessoryType = .disclosureIndicator
        default:
            cell.textLabel?.text = "Bank Accounts"
            cell.accessoryType = .disclosureIndicator
        }
        
        if (indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0){
            let mySeperator = UIView()
            mySeperator.backgroundColor = tableView.separatorColor
            cell.addSubview(mySeperator)
            mySeperator.anchor(top: nil, bottom: cell.bottomAnchor, leading: cell.leadingAnchor, trailing: cell.trailingAnchor, constant: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 0.3))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && indexPath.section == 0{
           payDelegate.pushToPaymentScreen()
        }
    }
    
}


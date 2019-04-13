//
//  TopTransactionDetailCell.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TopTransactionDetailCell: UITableViewCell {
    static let cellID = "TopTransactionDetailCell"
    var transaction : Transaction?{
        didSet{
            updateCell()
        }
    }
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let dailyCashLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let disclourseIcon : UIButton = {
        let button     = UIButton(type:.roundedRect)
        let disclosure = UITableViewCell()
        button.sizeToFit()
        disclosure.frame = button.bounds
        disclosure.accessoryType = .disclosureIndicator
        disclosure.isUserInteractionEnabled = false
        button.addSubview(disclosure)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(){
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        
        if let price = transaction?.price{
            let dailyCash = price * 0.02
            if let num = numberFormatter.string(from: NSNumber(value: dailyCash)){
                dailyCashLabel.text = "+$\(String(describing: num))"
                if dailyCash < 1 {
                    dailyCashLabel.text?.insert("0", at: dailyCashLabel.text!.index(dailyCashLabel.text!.startIndex, offsetBy: 2))
                }
            }
            
            if let num = numberFormatter.string(from: NSNumber(value: price)){
                priceLabel.text = "$\(String(describing: num))"
                if price < 1{
                    priceLabel.text?.insert("0", at: priceLabel.text!.index(priceLabel.text!.startIndex, offsetBy: 2))
                }
            }
        }
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .gray
        textLabel?.text = transaction?.date
        textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        detailTextLabel?.text = "2% Daily Cash"
    }
    
    func setupViews(){
        addSubview(disclourseIcon)
        addSubview(priceLabel)
        addSubview(dailyCashLabel)
        
        let constraints = [
            disclourseIcon.centerYAnchor.constraint(equalTo: textLabel!.centerYAnchor),
            disclourseIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            priceLabel.centerYAnchor.constraint(equalTo: textLabel!.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: disclourseIcon.leadingAnchor, constant: 5),
            
            dailyCashLabel.centerYAnchor.constraint(equalTo: detailTextLabel!.centerYAnchor),
            dailyCashLabel.trailingAnchor.constraint(equalTo: disclourseIcon.leadingAnchor, constant: 5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

//
//  TransactionHistoryCell.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TransactionHistoryCell: UITableViewCell {
    
    static let cellID = "TransactionHistoryCell"
    
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
    
    lazy var dailyCashPercentage = DailyCashPercentageLabel(frame: frame)

    let disclourseIcon : UIButton = {
        let button = UIButton(type:.roundedRect)
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
        if let city = transaction?.city{
            if let state = transaction?.state{
                detailTextLabel?.text = ("\(city), \(state)")
            }
        } else{
            detailTextLabel?.text = ("Online")
        }
    }
    
    func setupViews(){
        [disclourseIcon, priceLabel, dailyCashPercentage].forEach({addSubview($0)})
        
        let constraints = [
            disclourseIcon.centerYAnchor.constraint(equalTo: textLabel!.centerYAnchor),
            disclourseIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            priceLabel.centerYAnchor.constraint(equalTo: textLabel!.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: disclourseIcon.leadingAnchor, constant: 5),
            
            dailyCashPercentage.centerYAnchor.constraint(equalTo: detailTextLabel!.centerYAnchor),
            dailyCashPercentage.trailingAnchor.constraint(equalTo: disclourseIcon.leadingAnchor, constant: 5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


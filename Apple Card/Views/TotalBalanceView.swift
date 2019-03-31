//
//  TotalBalanceView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TotalBalanceView : UIView{
    
    init(frame: CGRect, amount: Double) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        let text = NSMutableAttributedString()
        let attr1 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 15),
        ]
        let attributedText1 = NSMutableAttributedString(string: "Total Balance", attributes: attr1)
        text.append(attributedText1)
        
        let attr2 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        let formatted = String(format: "\n$%.2f", amount)
        let attributedText2 = NSMutableAttributedString(string: formatted, attributes: attr2)
        text.append(attributedText2)
        
        let attr3 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12),
        ]
        let attributedText3 = NSMutableAttributedString(string: "\n$8,317.45 Avaliable", attributes: attr3)
        text.append(attributedText3)
        
        let label = UILabel()
        label.attributedText = text
        label.numberOfLines = 0
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        let constraints = [
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

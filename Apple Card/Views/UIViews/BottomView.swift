//
//  BottomView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class BottomView : UIView{
    let label = UILabel()
    var text = String()
    
    let payButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.isHidden = true
        return button
    }()

    var amount : Double! {
        didSet{
            let text = NSMutableAttributedString()
            
            let attr1 : [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 16),
            ]
            let attributedText1 = NSMutableAttributedString(string: "\(self.text)", attributes: attr1)
            text.append(attributedText1)
            
            let attr2 : [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.init(name: "ArialRoundedMTBold", size: 34)!
            ]
            let formatted = String(format: "\n$%.2f", amount)
            let attributedText2 = NSMutableAttributedString(string: formatted, attributes: attr2)
            text.append(attributedText2)
            
            label.attributedText = text
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.numberOfLines = 0
            label.sizeToFit()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let size = frame.height * 0.075
        label.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9724542499, green: 0.972597301, blue: 0.9724345803, alpha: 1)
        layer.borderWidth = 0.5
        layer.borderColor = (UITableView().separatorColor)?.cgColor
        addSubview(label)
        addSubview(payButton)
        
        payButton.anchor(top: topAnchor, bottom: label.bottomAnchor, leading: nil, trailing: trailingAnchor, constant: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init(width: size, height: size))
        
        payButton.roundCorners(radius: size / 2)

        let constraints = [
            label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

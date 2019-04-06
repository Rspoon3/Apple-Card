//
//  PaymentDueView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class PaymentDueView : UIView{
    
    @objc func pay(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "payFromMainScreen"), object: nil)
    }
    
    
    lazy var button : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        roundCorners(radius: 10)

        let text = NSMutableAttributedString()
        let attr1 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20),
        ]
        let attributedText1 = NSMutableAttributedString(string: "Payment Due In", attributes: attr1)
        text.append(attributedText1)
        
        let attr2 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 35)
        ]
        let attributedText2 = NSMutableAttributedString(string: "\n6 Days", attributes: attr2)
        text.append(attributedText2)
        
        let label = UILabel()
        label.attributedText = text
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        [label, button].forEach({addSubview($0)})
        
        let constraints = [
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: (1/3)),
            button.widthAnchor.constraint(equalTo: heightAnchor, multiplier: (1/3))
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.roundCorners(radius: button.frame.height / 2)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


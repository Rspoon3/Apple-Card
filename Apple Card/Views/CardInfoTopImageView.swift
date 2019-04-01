//
//  CardInfoTopImageView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class CardInfoTopImageView : UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let label = UILabel()
        let text = NSMutableAttributedString()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "theCard"))
        
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let attr1 : [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 30)
        ]
        let attributedText1 = NSMutableAttributedString(string: "Apple Card", attributes: attr1)
        text.append(attributedText1)
        
        let attr2 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16),
        ]
        let attributedText2 = NSMutableAttributedString(string: "\nPayment Card", attributes: attr2)
        text.append(attributedText2)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = text
        label.numberOfLines = 0
        label.textAlignment = .center
        
        addSubview(imageView)
        addSubview(label)
                
        let constriants = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.27),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constriants)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .bgColor
    }
    
}


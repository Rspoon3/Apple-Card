//
//  HeroImageView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class HeroImageView : UIView{
    
    init(frame: CGRect, transaction: Transaction) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        let text = NSMutableAttributedString()
        
        let attr1 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 15)
        ]
        let attributedText1 = NSMutableAttributedString(string: transaction.category, attributes: attr1)
        text.append(attributedText1)
        
        let attr2 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 25),
        ]
        let attributedText2 = NSMutableAttributedString(string: "\n\(transaction.title)", attributes: attr2)
        text.append(attributedText2)
        
        let attr3 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightText,
            .font: UIFont.systemFont(ofSize: 15),
        ]
        let attributedText3 = NSMutableAttributedString(string: "\nPhoto from Yelp", attributes: attr3)
        text.append(attributedText3)
        
        let label = UILabel()
        label.attributedText = text
        label.textAlignment  = .right
        label.numberOfLines  = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let heroImageView = UIImageView(image: transaction.heroImage)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.contentMode = .scaleToFill
        
        let logoImageView = UIImageView(image: transaction.logo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.roundCorners(radius: 10)

        [label, heroImageView, logoImageView, label].forEach({addSubview($0)})
        
        let constraints = [
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: (1/3.5)),
            logoImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: (1/3.5)),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


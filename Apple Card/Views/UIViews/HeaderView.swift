//
//  HeaderView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class HeaderView : UIView{
    var mainImageView : UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.widthAnchor.constraint(equalToConstant: mainImageView.frame.height).isActive = true
    }
    
    init(frame: CGRect, image: UIImage, title: String, subTitle: String) {
        super.init(frame: frame)
        backgroundColor = UIColor.bgColor
        translatesAutoresizingMaskIntoConstraints = false
        let text = NSMutableAttributedString()
        
        let attr1 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 30)
        ]
        let attributedText1 = NSMutableAttributedString(string:title, attributes: attr1)
        text.append(attributedText1)
        
        let attr2 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16),
        ]
        let attributedText2 = NSMutableAttributedString(string: "\n\(subTitle)", attributes: attr2)
        text.append(attributedText2)
        
        mainImageView = UIImageView(image: image)
        mainImageView.roundCorners(radius: 10)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.attributedText = text
        label.backgroundColor = UIColor.bgColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(mainImageView)
        
        let constraints = [
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: label.frame.height),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -20),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

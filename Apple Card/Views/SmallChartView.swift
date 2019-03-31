//
//  SmallChartView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class SmallChartView : UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        let label = UILabel()
        label.text = "Weekly Activity"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "smallChart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        [label, imageView].forEach({addSubview($0)})
        
        let constraints = [
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


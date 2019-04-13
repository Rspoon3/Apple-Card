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
        roundCorners(radius: 10)
        
        let label  = UILabel()
        label.text = "Weekly Activity"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "smallChart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        [label, imageView].forEach({addSubview($0)})
        
        label.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, constant: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        imageView.anchor(top: label.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, constant: .init(top: 5, left: 2, bottom: 5, right: 10))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


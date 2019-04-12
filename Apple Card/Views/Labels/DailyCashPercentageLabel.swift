//
//  DailyCashPercentageLabel.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/9/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class DailyCashPercentageLabel: UILabel{
    
    override var intrinsicContentSize: CGSize{
        let original = super.intrinsicContentSize
        return CGSize(width: original.width + 10, height: original.height + 5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let randomPercents = [1, 1, 2, 2, 2] //Gives a higher percentage of picking a 2
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        font = UIFont.systemFont(ofSize: 10)
        textColor = .gray
        text = "\(randomPercents.randomElement()!)%"
        textAlignment = .center
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        roundCorners(radius: 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

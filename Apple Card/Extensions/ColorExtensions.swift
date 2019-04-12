//
//  ColorExtension.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/7/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

extension UIColor{
    static let bgColor = #colorLiteral(red: 0.9541429877, green: 0.9484686255, blue: 0.9746612906, alpha: 1)
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    struct Apple {
        static let red      = UIColor(displayP3Red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1)
        static let orange   = UIColor(displayP3Red: 255.0/255.0, green: 149.0/255.0, blue: 0, alpha: 1)
        static let yellow   = UIColor(displayP3Red: 255.0/255.0, green: 204.0/255.0, blue: 0, alpha: 1)
        static let green    = UIColor(displayP3Red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1)
        static let tealBlue = UIColor(displayP3Red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1)
        static let blue     = UIColor(displayP3Red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
        static let purple   = UIColor(displayP3Red: 88.0/255.0, green: 86.0/255.0, blue: 214.0/255.0, alpha: 1)
        static let pink     = UIColor(displayP3Red: 255.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1)
    }
}


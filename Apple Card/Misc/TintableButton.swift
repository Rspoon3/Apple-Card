//
//  TintableButton.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/2/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TintableButton: UIButton{
    init(frame: CGRect , image: UIImage, color: UIColor, size: CGSize? ) {
        super.init(frame: frame)
        var newImage : UIImage
        if let unwrappedSize = size{
            newImage = image.resizedImage(newSize: unwrappedSize)
        } else {
            newImage = image
        }
        let tintableImage = newImage.withRenderingMode(.alwaysTemplate) //has to be alwaysTemplate
        tintColor = color
        setImage(tintableImage, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



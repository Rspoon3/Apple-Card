//
//  Extensions.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
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
        static let red = UIColor(displayP3Red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1)
        static let orange = UIColor(displayP3Red: 255.0/255.0, green: 149.0/255.0, blue: 0, alpha: 1)
        static let yellow = UIColor(displayP3Red: 255.0/255.0, green: 204.0/255.0, blue: 0, alpha: 1)
        static let green = UIColor(displayP3Red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1)
        static let tealBlue = UIColor(displayP3Red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1)
        static let blue = UIColor(displayP3Red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
        static let purple = UIColor(displayP3Red: 88.0/255.0, green: 86.0/255.0, blue: 214.0/255.0, alpha: 1)
        static let pink = UIColor(displayP3Red: 255.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1)
    }
}

extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Returns a resized image that fits in rectSize, keeping it's aspect ratio
    /// Note that the new image size is not rectSize, but within it.
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
}


extension UIView {
    
    func roundCorners(radius: CGFloat){
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func roundTopCorners(radius: CGFloat){
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func roundBottomCorners(radius: CGFloat){
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, bottom: superview?.bottomAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor)
    }
    
    func fillSafeSuperview(safeTop: Bool, safeBottom: Bool, safeLeading: Bool, safeTrialing: Bool) {
        var topAnchor = superview?.topAnchor
        var bottomAnchor = superview?.bottomAnchor
        var leadingAnchor = superview?.leadingAnchor
        var trailingAnchor = superview?.trailingAnchor
        
        if safeTop{
            topAnchor = superview?.safeAreaLayoutGuide.topAnchor
        }
        if safeBottom{
            bottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor
        }
        if safeLeading{
            leadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor
        }
        if safeTrialing{
            trailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor
        }

        anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, constant: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: constant.top))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -constant.bottom))
        }
        
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: constant.left))
        }
        
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -constant.right))
        }
        
        if size.width != 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: size.width))
        }
        
        if size.height != 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: size.height))
        }
        
        NSLayoutConstraint.activate(anchors)
    }
    
    func anchorHegihtWidth(height: NSLayoutDimension?, heightConstant: CGFloat?, heightMulitplier: CGFloat?, width: NSLayoutDimension?, widthConstant: CGFloat?, widthMulitplier: CGFloat?){
        var anchors = [NSLayoutConstraint]()
        var hConstant : CGFloat = 0
        var hMultiplier : CGFloat = 1
        var wConstant : CGFloat = 0
        var wMultiplier : CGFloat = 1
        
        translatesAutoresizingMaskIntoConstraints = false

        if let hc = heightConstant{
            hConstant = hc
        }
        
        if let hm = heightMulitplier{
            hMultiplier = hm
        }
        
        if let wc = widthConstant{
            wConstant = wc
        }
        
        if let wm = widthMulitplier{
            wMultiplier = wm
        }
        
        if let height = height {
            anchors.append(heightAnchor.constraint(equalTo: height, multiplier: hMultiplier, constant: hConstant))
        }
        
        if let width = width {
            anchors.append(widthAnchor.constraint(equalTo: width, multiplier: wMultiplier, constant: wConstant))
        }
        
        NSLayoutConstraint.activate(anchors)

    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}


















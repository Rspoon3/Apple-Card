//
//  CardInfoButtonsStackView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

protocol CardInfoButtonsStackViewDelegate {
    func openSupportWebsite()
    func callSupport()
    func openSupportMessages()
}

class CardInfoButtonsStackView: UIStackView {
    
    var mydelegate : CardInfoButtonsStackViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let messageView = UIView()
        let callView = UIView()
        let webView = UIView()
        let allViews = [messageView, callView, webView]
        let images : [UIImage] = [#imageLiteral(resourceName: "messageIcon"), #imageLiteral(resourceName: "phone"), #imageLiteral(resourceName: "safari")]
        let text = ["Message", "Call", "Website"]
        let messageTap = UITapGestureRecognizer(target: self, action: #selector(messageTapped))
        let callTap = UITapGestureRecognizer(target: self, action: #selector(callTapped))
        let webTap = UITapGestureRecognizer(target: self, action: #selector(webTapped))
        messageTap.numberOfTapsRequired = 1
        callTap.numberOfTapsRequired = 1
        webTap.numberOfTapsRequired = 1
        
        for (index, view) in allViews.enumerated(){
            let label = UILabel()
            let tintableImage = images[index].withRenderingMode(.alwaysTemplate)
            let imageView = UIImageView()
            imageView.image = tintableImage
            imageView.tintColor = UIView().tintColor
            imageView.contentMode = .scaleAspectFit
            label.text = text[index]
            label.textAlignment = .center
            label.textColor = UIView().tintColor
            
            let subStack = UIStackView(arrangedSubviews: [imageView,label])
            subStack.translatesAutoresizingMaskIntoConstraints = false
            subStack.axis = .vertical
            subStack.distribution = .fillEqually
            
            view.addSubview(subStack)
            let constraints = [
                subStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
                subStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                subStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                subStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            ]
            NSLayoutConstraint.activate(constraints)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.roundCorners(radius: 10)
            view.backgroundColor = .white
            addArrangedSubview(view)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .bgColor
        axis = .horizontal
        distribution = .fillEqually
        spacing = 10
        
        subviews.first?.addGestureRecognizer(messageTap)
        subviews[1].addGestureRecognizer(callTap)
        subviews.last?.addGestureRecognizer(webTap)
    }
    
    @objc func callTapped(){
        mydelegate.callSupport()
    }
    
    @objc func messageTapped(){
        mydelegate.openSupportMessages()
    }
    
    @objc func webTapped(){
        mydelegate.openSupportWebsite()
    }
}



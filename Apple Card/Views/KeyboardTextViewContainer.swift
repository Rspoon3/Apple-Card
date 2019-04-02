//
//  KeyboardTextViewContainer.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/1/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class KeyboardTextViewContainer : BaseView, UITextViewDelegate{
    
    let everythingContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    let textViewSendButtonContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    let textView : VerticallyCenteredTextView = {
        let view = VerticallyCenteredTextView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = .white
        view.text = "Placeholder"
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    let sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIView().tintColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()
    
    let buttonStack : UIStackView = {
        let cameraButton = UIButton(type: .detailDisclosure)
        let infoButton = UIButton(type: .infoLight)
        let stack = UIStackView(arrangedSubviews: [infoButton, cameraButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    

    
    override func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        
        addSubview(everythingContainer)
        everythingContainer.addSubview(textViewSendButtonContainer)
        everythingContainer.addSubview(buttonStack)
        textViewSendButtonContainer.addSubview(textView)
        textViewSendButtonContainer.addSubview(sendButton)
        
        let constraints = [
            everythingContainer.topAnchor.constraint(equalTo: topAnchor),
            everythingContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            everythingContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            everythingContainer.leadingAnchor.constraint(equalTo:  leadingAnchor),
            
            textViewSendButtonContainer.topAnchor.constraint(equalTo: everythingContainer.topAnchor, constant: 5),
            textViewSendButtonContainer.bottomAnchor.constraint(equalTo: everythingContainer.bottomAnchor),
            textViewSendButtonContainer.trailingAnchor.constraint(equalTo: everythingContainer.trailingAnchor),
            textViewSendButtonContainer.leadingAnchor.constraint(equalTo:  everythingContainer.leadingAnchor, constant: frame.width * 0.2),
            
            buttonStack.topAnchor.constraint(equalTo: everythingContainer.topAnchor, constant: 5),
            buttonStack.bottomAnchor.constraint(equalTo: everythingContainer.bottomAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: textViewSendButtonContainer.leadingAnchor, constant: 10),
            buttonStack.leadingAnchor.constraint(equalTo:  everythingContainer.leadingAnchor),
            
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: textViewSendButtonContainer.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: textViewSendButtonContainer.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: textViewSendButtonContainer.trailingAnchor, constant: -75),
            
            sendButton.topAnchor.constraint(equalTo: topAnchor),
            sendButton.bottomAnchor.constraint(equalTo: textViewSendButtonContainer.bottomAnchor),
            sendButton.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 5),
            sendButton.trailingAnchor.constraint(equalTo: textViewSendButtonContainer.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    override func layoutSubviews() {
        textViewSendButtonContainer.layer.cornerRadius = textViewSendButtonContainer.frame.height / 2
        textViewSendButtonContainer.layer.masksToBounds = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        textView.textColor = .black
        textView.text = nil
    }

}

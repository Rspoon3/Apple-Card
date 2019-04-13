//
//  KeyboardTextViewContainer.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/1/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

protocol SendMessageDelegate {
    func sendMessage(message: String)
}

class KeyboardTextViewContainer : BaseView, UITextViewDelegate{
    
    var sendMessageDelegate : SendMessageDelegate?
    
    let everythingContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    @objc func scrollToDismissKeyboard(){
        
    }
    let textViewSendButtonContainer : UIView = {
        let view = UIView()
        view.backgroundColor   = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    let placeHolderText = "To: Apple"
    
    lazy var textView : VerticallyCenteredTextView = {
        let view = VerticallyCenteredTextView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = .white
        view.text = placeHolderText
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    lazy var buttonStack : UIStackView = {
        let color = #colorLiteral(red: 0.4650884271, green: 0.4987065196, blue: 0.5242561102, alpha: 1)
        let cameraButton   = TintableImageButton(frame: frame, image: #imageLiteral(resourceName: "camera"), color: color, size: CGSize(width: 30, height: 30))
        let appStoreButton = TintableImageButton(frame: frame, image: #imageLiteral(resourceName: "appStoreIcon"), color: color, size: CGSize(width: 26, height: 26))
        let stack = UIStackView(arrangedSubviews: [cameraButton, appStoreButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .red
        return stack
    }()
    
    override func setupViews() {
        let sendButton = TintableImageButton(frame: frame, image: #imageLiteral(resourceName: "iMessageSendButton"), color: #colorLiteral(red: 0.4650884271, green: 0.4987065196, blue: 0.5242561102, alpha: 1), size: CGSize(width: 30, height: 30))
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
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
            buttonStack.trailingAnchor.constraint(equalTo: textViewSendButtonContainer.leadingAnchor, constant: -10),
            buttonStack.leadingAnchor.constraint(equalTo:  everythingContainer.leadingAnchor),
            
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: textViewSendButtonContainer.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: textViewSendButtonContainer.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            
            sendButton.topAnchor.constraint(equalTo: topAnchor),
            sendButton.bottomAnchor.constraint(equalTo: textViewSendButtonContainer.bottomAnchor),
            sendButton.trailingAnchor.constraint(equalTo: textViewSendButtonContainer.trailingAnchor, constant: -5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        textViewSendButtonContainer.roundCorners(radius: textViewSendButtonContainer.frame.height / 2)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        textView.textColor = .black
        textView.text = nil
    }
    
    @objc func handleSend(){
        if textView.text != ""{
            if textView.text != placeHolderText{
                sendMessageDelegate?.sendMessage(message: textView.text)
            }
        }
    }

}

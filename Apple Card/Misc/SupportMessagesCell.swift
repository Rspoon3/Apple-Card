//
//  SupportMessagesCell.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/1/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class SupportMessagesCell: BaseCollectionViewCell {
    
    let cellID = "SupportMessagesCell"
    
    let messageView : UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
        view.backgroundColor = .clear
        view.isEditable = false
        return view
    }()
    
    let textBubbleView : UIView = {
        let view = UIView()
        return view
    }()
    
    static let sendingBubble = #imageLiteral(resourceName: "bubbleSent").resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
    
    static let receivingBubble = #imageLiteral(resourceName: "bubbleReceived").resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView : UIImageView = {
        let view = UIImageView()
        view.image = SupportMessagesCell.receivingBubble
        view.tintColor = UIColor(white: 0.95, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    override func layoutSubviews() {
        textBubbleView.layer.cornerRadius = 15
        textBubbleView.layer.masksToBounds = true
    }

    override func setupViews() {
        backgroundColor = .white
        addSubview(textBubbleView)
        addSubview(messageView)
        
        textBubbleView.addSubview(bubbleImageView)
        let constraints = [
            bubbleImageView.topAnchor.constraint(equalTo: textBubbleView.topAnchor),
            bubbleImageView.bottomAnchor.constraint(equalTo: textBubbleView.bottomAnchor),
            bubbleImageView.leadingAnchor.constraint(equalTo: textBubbleView.leadingAnchor),
            bubbleImageView.trailingAnchor.constraint(equalTo: textBubbleView.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    
 
}

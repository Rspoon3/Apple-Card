//
//  SupportMessagesCell.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/1/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class SupportMessagesCell: BaseCollectionViewCell {
    
    var isSender : Bool!{
        didSet{
            if self.isSender{
                updateCell(image: SupportMessagesCell.sendingBubble, textColor: .white, backgroundColor: .gray)
            } else {
                updateCell(image: SupportMessagesCell.receivingBubble, textColor: .black, backgroundColor: UIColor.init(white: 0.95, alpha: 1))
            }
        }
    }
    
    let cellID = "SupportMessagesCell"
    
    static let sendingBubble = #imageLiteral(resourceName: "bubbleSent").resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
    
    static let receivingBubble = #imageLiteral(resourceName: "bubbleReceived").resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26), resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
    
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
    
    let bubbleImageView : UIImageView = {
        let view = UIImageView()
        view.image = SupportMessagesCell.receivingBubble
        view.tintColor = UIColor(white: 0.95, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    override func layoutSubviews() {
        textBubbleView.roundCorners(radius: 15)
    }

    override func setupViews() {
        backgroundColor = .white
        addSubview(textBubbleView)
        addSubview(messageView)
        
        textBubbleView.addSubview(bubbleImageView)
        bubbleImageView.fillSuperview()
    }

    func updateCell(image: UIImage, textColor: UIColor, backgroundColor: UIColor) {
        bubbleImageView.image     = image
        messageView.textColor     = textColor
        bubbleImageView.tintColor = backgroundColor
    }
    
 
}

//
//  SupportMessagesCollectionViewController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/1/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SupportMessagesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let sampleMessages = [
        "Hi. How are you today?",
        "I think I lost my physical card. Do you know if I can get a new one? If so do I have to pay for it??",
        "We can just send you one",
        "Really?!",
        "Yeah dont worry about it. Its on us.",
        "Thanks this is really great news!",
        
        "Hours 7: I don’t know how long I’ve been stuck staring at this page. The blinking cursor represents an eternity. I’m starting to think that I’ll never escape practical 5. I know I just need to type about 200 words and then I’m don’t but I can’t. I’m too run down. Between the words and obnoxious amount of figures I’ve run out of steam. I think this is the end."
    ]
    
    let messageInputContainerView : UIView = {
        let view = UIImageView()
        view.backgroundColor = .lightText
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()

    let messageInputTextField : UITextField = {
        let view = UITextField()
        view.placeholder = "To: Apple"
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    let supportMessagesCell = SupportMessagesCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
        self.collectionView!.register(SupportMessagesCell.self, forCellWithReuseIdentifier: supportMessagesCell.cellID)
        
        
        view.addSubview(messageInputContainerView)
        let constraints = [
            messageInputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputContainerView.heightAnchor.constraint(equalToConstant: 48),
        ]
        NSLayoutConstraint.activate(constraints)
        
        setupInputComponents()
        
    }
    
    func setupInputComponents(){
        messageInputContainerView.addSubview(messageInputTextField)
        let constraints = [
            messageInputTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor),
            messageInputTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor),
            messageInputTextField.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor),
            messageInputTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMessages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: supportMessagesCell.cellID, for: indexPath) as! SupportMessagesCell
        cell.messageView.text = sampleMessages[indexPath.item]
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: sampleMessages[indexPath.item]).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
        if indexPath.item.isMultiple(of: 2){
           //us
            cell.messageView.frame = CGRect(x:  view.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 19 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
            cell.messageView.textColor = .white
            cell.bubbleImageView.image = SupportMessagesCell.sendingBubble
            cell.bubbleImageView.tintColor = .gray
        } else {
            //apple support
            cell.messageView.frame = CGRect(x: 19 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: 19 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
            cell.messageView.textColor = .black
            cell.bubbleImageView.image = SupportMessagesCell.receivingBubble
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: sampleMessages[indexPath.item]).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    

}

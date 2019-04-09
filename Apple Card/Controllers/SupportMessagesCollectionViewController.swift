//
//  SupportMessagesCollectionViewController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/1/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SupportMessagesCollectionViewController:  UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, SendMessageDelegate{
    
    let automaticReplyMessages = [
        SupportMessage(message: "Sorry I'm out of the office. I will see this when I return.\n\nThis is an auotmated response.", isSender: false, dateSent: Date()),
        SupportMessage(message: "Receipents status is: On vacation. They will see this when they return.\n\nThis is an auotmated response.", isSender: false, dateSent: Date()),
        SupportMessage(message: "Im not here right now. I will get back to you later.\n\nThis is an auotmated response.", isSender: false, dateSent: Date()),
        SupportMessage(message: "Im gone.\n\nThis is an auotmated response.", isSender: false, dateSent: Date()),
        SupportMessage(message: "I can't help with that at the moment because I not around\n\nThis is an auotmated response.", isSender: false, dateSent: Date()),
        SupportMessage(message: "I'll help you when I get back into town.\n\nThis is an auotmated response.", isSender: false, dateSent: Date()),
    ]
    
    var sampleMessages = [
        SupportMessage(message: "Hi. When will I receive my titanium card?", isSender: true, dateSent: Date()),
        SupportMessage(message: "One momenet let me check.", isSender: false, dateSent: Date()),
        SupportMessage(message: "I can see that it was shipped this morning. It should be there in about three days.", isSender: false, dateSent: Date()),
        SupportMessage(message: "Okay thank you.", isSender: true, dateSent: Date()),
        SupportMessage(message: "No problem. Is there anything else I can do to help you?", isSender: false, dateSent: Date()),
        SupportMessage(message: "Not today", isSender: true, dateSent: Date()),
]
    
    func sendMessage(message: String) {
        let newMessage = SupportMessage(message: message, isSender: true, dateSent: Date())
        sendNewMessage(message: newMessage)
        keyboardTextView.textView.text = nil
        
        let random = Double.random(in: 1.2...3.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + random) {
            if let randomRely = self.automaticReplyMessages.randomElement(){
                self.sendNewMessage(message: randomRely)
            }
        }
    }
    
    fileprivate func sendNewMessage(message: SupportMessage){
        sampleMessages.append(message)
        let item = sampleMessages.count - 1
        let insertionIndex : IndexPath = IndexPath(item: item, section: 0)
        collectionView.insertItems(at: [insertionIndex])
        collectionView.scrollToItem(at: insertionIndex, at: .bottom, animated: true)
    }

    let supportMessagesCell = SupportMessagesCell()
    var keyboardTextView : KeyboardTextViewContainer!
    var bottomConstraint    : NSLayoutConstraint?
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let header = SupportMessageHeader(frame: view.frame)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .interactive
        collectionView.register(SupportMessagesCell.self, forCellWithReuseIdentifier: supportMessagesCell.cellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        view.addSubview(collectionView)
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(header)
        let infoButton = UIButton(type: .infoLight)
        navigationItem.rightBarButtonItem = .init(customView: infoButton)
        let resizedImage = #imageLiteral(resourceName: "appleLogo").resizedImage(newSize: CGSize(width: 30, height: 30))
        let appleLogoView = UIImageView(image: resizedImage)
        let tintableImage = resizedImage.withRenderingMode(.alwaysTemplate)
        appleLogoView.image = tintableImage
        appleLogoView.tintColor = .white
        appleLogoView.contentMode = .scaleAspectFit
        navigationItem.titleView = appleLogoView
        self.navigationItem.title = "Your Title"
        
        
        let text = NSMutableAttributedString()
        
        let attr1 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let attributedText1 = NSMutableAttributedString(string: "Apple ", attributes: attr1)
        text.append(attributedText1)
        
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = #imageLiteral(resourceName: "supportMessageCheckMark-1").resizedImage(newSize: CGSize(width: 10, height: 10))
        let imageString = NSAttributedString(attachment: image1Attachment)
        text.append(imageString)
        
        let attributedText2 = NSMutableAttributedString(string: " ")
        text.append(attributedText2)
        
        let image2Attachment = NSTextAttachment()
        image2Attachment.image = #imageLiteral(resourceName: "rightArrow").resizedImage(newSize: CGSize(width: 10, height: 10))
        let imageString2 = NSAttributedString(attachment: image2Attachment)
        text.append(imageString2)

        
        let label = UILabel()
        label.attributedText = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        view.addSubview(label)
        
        keyboardTextView = KeyboardTextViewContainer(frame: view.frame)
        keyboardTextView.sendMessageDelegate = self
        view.addSubview(keyboardTextView)
        bottomConstraint = keyboardTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint?.isActive = true
        let constraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 7),
            
            keyboardTextView.heightAnchor.constraint(equalToConstant: 45),
            keyboardTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            keyboardTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: keyboardTextView.topAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.scrollToBottom()
        }

    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        updateConstraints(height: 0, moveUp: false, duration: 0.3)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            updateConstraints(height: keyboardHeight, moveUp: true, duration: 0)
        }
    }

    fileprivate func scrollToBottom() {
        let indexPath : IndexPath = NSIndexPath(item: self.sampleMessages.count - 1, section: 0) as IndexPath
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateConstraints(height: CGFloat, moveUp: Bool, duration: Double){
        bottomConstraint?.isActive = false
        if moveUp{
            bottomConstraint = keyboardTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -height - 5)
        } else{
            bottomConstraint = keyboardTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        }
        bottomConstraint?.isActive = true
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (completed) in
            if moveUp{
                self.scrollToBottom()
            }
        
        })
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMessages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: supportMessagesCell.cellID, for: indexPath) as! SupportMessagesCell
        cell.messageView.text = sampleMessages[indexPath.item].message

        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: sampleMessages[indexPath.item].message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

        if sampleMessages[indexPath.item].isSender{
           //us
            cell.isSender = true
            cell.messageView.frame = CGRect(x:  view.frame.width - estimatedFrame.width - 16 - 8 - 19, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: UIScreen.main.bounds.width - estimatedFrame.width - 16 - 8 - 19 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
        } else {
            //apple support
            cell.isSender = false
            cell.messageView.frame = CGRect(x: 19 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: 19 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: sampleMessages[indexPath.item].message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        if indexPath.item == sampleMessages.count - 1{
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 25)
        }

        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateConstraints(height: 0, moveUp: false, duration: 0.3)
        keyboardTextView.endEditing(true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
        let label = UILabel()
        let text = NSMutableAttributedString()
        let attr1 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.boldSystemFont(ofSize: 12)
        ]
        let attr2 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        let attributedText1 = NSMutableAttributedString(string: "Today", attributes: attr1)
        let attributedText2 = NSMutableAttributedString(string: " 9:41 AM", attributes: attr2)
        text.append(attributedText1)
        text.append(attributedText2)
        label.attributedText = text
        label.textAlignment = .center
        headerView.addSubview(label)
        label.fillSuperview()
        return headerView
    }
    

}

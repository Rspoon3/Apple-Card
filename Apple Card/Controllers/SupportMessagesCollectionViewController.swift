//
//  SupportMessagesCollectionViewController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/1/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SupportMessagesCollectionViewController:  UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    let sampleMessages = [
        SupportMesage(message: "Hi. How are you today?", isSender: true, dateSent: Date()),
        SupportMesage(message: "I think I lost my physical card. Do you know if I can get a new one? If so do I have to pay for it?", isSender: true, dateSent: Date()),
        SupportMesage(message: "We can just send you one.", isSender: false, dateSent: Date()),
        SupportMesage(message: "Really?!", isSender: true, dateSent: Date()),
        SupportMesage(message: "Yeah dont worry about it. Its on us.", isSender: false, dateSent: Date()),
        SupportMesage(message: "I just put in the request for you.", isSender: false, dateSent: Date()),
        SupportMesage(message: "Thanks this is really great news!", isSender: true, dateSent: Date()),
        SupportMesage(message: "Hours 7: I don’t know how long I’ve been stuck staring at this page. The blinking cursor represents an eternity. I’m starting to think that I’ll never escape practical 5. I know I just need to type about 200 words and then I’m don’t but I can’t. I’m too run down. Between the words and obnoxious amount of figures I’ve run out of steam. I think this is the end.?", isSender: true, dateSent: Date()),
        SupportMesage(message: "Sorry wrong person.", isSender: true, dateSent: Date()),
        SupportMesage(message: "What I meant to say was that my card is lost.", isSender: true, dateSent: Date()),
        SupportMesage(message: "Can we send you another one right away.", isSender: false, dateSent: Date()),
        SupportMesage(message: "Awesome thanks!", isSender: true, dateSent: Date()),
]

    let supportMessagesCell = SupportMessagesCell()
    var keyboardTextView : KeyboardTextViewContainer!
    var bottomConstraint    : NSLayoutConstraint?
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let header = SupportMessageHeader(frame: view.frame)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SupportMessagesCell.self, forCellWithReuseIdentifier: supportMessagesCell.cellID)
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
        let label = UILabel()
        label.text = "Apple"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        view.addSubview(label)
        
        keyboardTextView = KeyboardTextViewContainer(frame: view.frame)
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
            
            collectionView.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor),
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.scrollToBottom()
        }

    }
    
   
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            updateConstraints(height: keyboardHeight, moveUp: true)
        }
    }

    fileprivate func scrollToBottom() {
        let indexPath : IndexPath = NSIndexPath(item: self.sampleMessages.count - 1, section: 0) as IndexPath
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateConstraints(height: CGFloat, moveUp: Bool){
        bottomConstraint?.isActive = false
        if moveUp{
            bottomConstraint = keyboardTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -height - 5)
        } else{
            bottomConstraint = keyboardTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        }
        bottomConstraint?.isActive = true
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
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
            cell.messageView.frame = CGRect(x:  view.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.textBubbleView.frame = CGRect(x: UIScreen.main.bounds.width - estimatedFrame.width - 16 - 8 - 19 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
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
        updateConstraints(height: 0, moveUp: false)
        keyboardTextView.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        updateConstraints(height: 0, moveUp: false)
        keyboardTextView.resignFirstResponder()
        return true
    }

}

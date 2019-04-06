//
//  PaymentViewController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/4/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

//intern
class PaymentViewController: UIViewController{

    lazy var paymentButtonStack : UIStackView = {
        let payLater = UIButton(type: .system)
        let payNow = UIButton(type: .system)
        payLater.setTitle("Pay Later", for: .normal)
        payLater.setTitleColor(.black, for: .normal)
        payLater.backgroundColor = .white
        payLater.roundCorners(radius: 10)
        payNow.setTitle("Pay Now", for: .normal)
        payNow.setTitleColor(.white, for: .normal)
        payNow.backgroundColor = .black
        payNow.roundCorners(radius: 10)
        let stack = UIStackView(arrangedSubviews: [payLater,payNow])
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    let showKeyPad : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Keypad", for: .normal)
        button.sizeToFit()
        return button
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    let topText : NSMutableAttributedString = {
        let text = NSMutableAttributedString()
        let attr1 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 40)
        ]
        let attr2 : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 15)
        ]
        let attributedText1 = NSMutableAttributedString(string: "Choose Amount", attributes: attr1)
        let attributedText2 = NSMutableAttributedString(string: "\nMake Payments by March 31.", attributes: attr2)
        text.append(attributedText1)
        text.append(attributedText2)
        return text
    }()
    
    lazy var topLabel : UILabel = {
        let label = UILabel()
        label.attributedText = topText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let totalBalance : CGFloat = 1682.55
    
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        var num = totalBalance * (40/360)
        num = (num * 100).rounded() / 100
        label.font = UIFont.init(name: "ArialRoundedMTBold", size: UIScreen.main.bounds.height * 0.06)!
        label.text = "$\(num)"
        label.sizeToFit()
        return label
    }()
    
    lazy var topCurvedLabel : CurvedLabel = {
        let label = CurvedLabel()
        label.textAlignment = .center
        label.text = "TOTAL BALANCE: $\(totalBalance)"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clockwise = true
        label.angle = 1.5
        label.radius = view.frame.width * 0.28
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var bottomCurvedLabel : CurvedLabel = {
        let label = CurvedLabel()
        label.textAlignment = .center
        label.text = "NO INTREST CHARGES"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clockwise = false
        label.angle = -1.5
        label.radius = view.frame.width * 0.28
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var bottomLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    let ringContainer = BaseView()
    
    var hasLaidOutRing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgColor
        updateBottomText(string1: "Reduce Intrest Charges", string2: "\nPaying more than the minimum amount each month will help you reduce or even avoid intrest charges.")
        
        [topLabel, bottomLabel, paymentButtonStack, showKeyPad, ringContainer, cancelButton].forEach({view.addSubview($0)})
        
        [priceLabel, topCurvedLabel, bottomCurvedLabel].forEach({ringContainer.addSubview($0)})
        
        priceLabel.anchorCenterSuperview()
        
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, constant: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        topCurvedLabel.anchor(top: nil, bottom: ringContainer.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: view.frame.height * 0.38))
        
        bottomCurvedLabel.anchor(top: nil, bottom: ringContainer.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: .init(top: 0, left: 0, bottom: view.frame.height  * 0.05, right: 0), size: CGSize(width: 0, height: view.frame.height * 0.3))


        topLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: .init(top: view.frame.height * 0.05, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: view.frame.height * 0.125))

        ringContainer.anchor(top: topLabel.bottomAnchor, bottom: bottomLabel.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: .init(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: view.frame.height * 0.4))

        bottomLabel.anchor(top: ringContainer.bottomAnchor, bottom: paymentButtonStack.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: .init(top: 0, left: 20, bottom: 0, right: 20))

        paymentButtonStack.anchor(top: nil, bottom: showKeyPad.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: .init(top: 0, left: 20, bottom: 20, right: 20), size: .init(width: 0, height: view.frame.height * 0.065))

        showKeyPad.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: .init(top: 0, left: 20, bottom: 20, right: 20))
    }
    
    override func viewDidLayoutSubviews() {
        if hasLaidOutRing { return }
        let frame = CGRect(x: 0, y: 0, width: ringContainer.frame.width, height: ringContainer.frame.height)
        let ring = PaymentRingView(frame: frame, trackRadius: view.frame.width * 0.37, ballRadius: 20, ballXOffset: 7, ballYOffset: 7)
        ring.ringDelegate = self
        ringContainer.addSubview(ring)
        hasLaidOutRing = true
    }
    
    func updateBottomText(string1 : String, string2 : String){
            let text = NSMutableAttributedString()
            let attr1 : [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
            let attr2 : [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 15)
            ]
            let attr3 : [NSAttributedString.Key: Any] = [
                .foregroundColor: UIView().tintColor!,
                .font: UIFont.systemFont(ofSize: 15)
            ]
            let attributedText1 = NSMutableAttributedString(string: string1, attributes: attr1)
            let attributedText2 = NSMutableAttributedString(string: string2, attributes: attr2)
            let attributedText3 = NSMutableAttributedString(string: " Learn More...", attributes: attr3)
            text.append(attributedText1)
            text.append(attributedText2)
            text.append(attributedText3)
            bottomLabel.attributedText = text
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}

extension PaymentViewController: RingDelegate {
    
    func updatePercent(percent: CGFloat) {
        let roundedPercent = (percent).rounded() / 100
        var price = totalBalance * roundedPercent
        price = (price * 100).rounded() / 100
        priceLabel.text = "$\(price)"
    }
    
    func changeText(color: String) {
        if color == "Red"{
            updateBottomText(string1: "Reduce Intrest Charges", string2: "\nPaying more than the minimum amount each month will help you reduce or even avoid intrest charges.")
        } else if color == "Yellow"{
            updateBottomText(string1: "Start a 3-Month Payment Plan", string2: "\nPay the suggested amount every month and your balance can be paid off in just three months.")
        } else{
            updateBottomText(string1: "Pay February Balance", string2: "\nPaying your monthly statement balance helps keep you financially healthy and and avoid intrest charges.")
        }
    }
}


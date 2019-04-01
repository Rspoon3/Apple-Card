//
//  CustumCell.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    static let cellID = "TransactionCell"
    var transaction : Transaction?{
        didSet{
            updateCell()
        }
    }

    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let disclourseIcon : UIButton = {
        let button = UIButton(type:.roundedRect)
        let disclosure = UITableViewCell()
        button.sizeToFit()
        disclosure.frame = button.bounds
        disclosure.accessoryType = .disclosureIndicator
        disclosure.isUserInteractionEnabled = false
        button.addSubview(disclosure)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = self.frame.height / 15
    }
    
    func updateCell(){
        let numberFormatter = NumberFormatter()
        let myimage = transaction!.image.resizedImage(newSize: CGSize(width: frame.height / 1.5, height: frame.height / 1.5))
        var detailText = ""

        numberFormatter.minimumFractionDigits = 2
        if let price = transaction?.price{
            if let num = numberFormatter.string(from: NSNumber(value: price)){
                priceLabel.text = "$\(String(describing: num))"
                if transaction?.image == UIImage(imageLiteralResourceName: "dailyCash"){
                    priceLabel.text?.insert("+", at: priceLabel.text!.startIndex)
                }
                if price < 1{
                    priceLabel.text?.insert("0", at: priceLabel.text!.index(priceLabel.text!.startIndex, offsetBy: 2))
                }
            }
        }
        imageView?.image = myimage
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .gray
        textLabel?.text = transaction?.title
        
        if let text = transaction?.city {
            detailText += text
        }
        
        if let text = transaction?.state {
            detailText += ", \(text)\n"
        }
        
        detailText += "\(String(describing: transaction!.date))"
        detailTextLabel?.text = detailText
    }
    
    func setupViews(){
        addSubview(disclourseIcon)
        addSubview(priceLabel)
        let constraints = [
            disclourseIcon.centerYAnchor.constraint(equalTo: textLabel!.centerYAnchor),
            disclourseIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            priceLabel.centerYAnchor.constraint(equalTo: textLabel!.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: disclourseIcon.leadingAnchor, constant: 5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


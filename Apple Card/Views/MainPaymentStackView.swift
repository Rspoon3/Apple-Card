//
//  MainPaymentStackView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class MainPaymentStackView : UIStackView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let totalBalance = TotalBalanceView(frame: frame, amount: 1682.55)
        let smallChartView = SmallChartView(frame: frame)
        let paymentDueView = PaymentDueView(frame: frame)
        let subStack = UIStackView(arrangedSubviews: [totalBalance, smallChartView])
        subStack.axis = .vertical
        subStack.distribution = .fillEqually
        subStack.spacing = 15
        
        [subStack, paymentDueView].forEach({addArrangedSubview($0)})
        
        axis = .horizontal
        distribution = .fillEqually
        spacing = 15
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

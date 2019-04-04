//
//  PaymentViewController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/4/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit


class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ring = PaymentRingView(frame: view.frame, trackRadius: view.frame.width * 0.37, ballRadius: 20, ballXOffset: 7, ballYOffset: 7)
        view.addSubview(ring)
    }
}

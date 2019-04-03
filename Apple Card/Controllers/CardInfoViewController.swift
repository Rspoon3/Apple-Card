//
//  CardInfoTableViewController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/31/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

//intern
class CardInfoViewController: UIViewController, CardInfoButtonsStackViewDelegate {
    
    //MARK: ivar
    var audioPlayer = AVAudioPlayer()
    lazy var tableView = CardInfoTableView(frame: view.frame, style: .grouped)
    lazy var scrollView = UIScrollView(frame: view.frame)
    lazy var headerImageView = CardInfoTopImageView(frame: view.frame)
    lazy var cardInfoButtonsStackView = CardInfoButtonsStackView(frame: view.frame)
    let containerView = UIView()

    override func viewDidLayoutSubviews() {
        let scrollHeight = view.frame.height - tableView.bounds.height - headerImageView.bounds.height - cardInfoButtonsStackView.bounds.height
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + scrollHeight)
    }
    
    //MARK: view functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
        view.backgroundColor = .bgColor
        view.addSubview(scrollView)
        
        containerView.frame = view.bounds
        scrollView.addSubview(containerView)
        [tableView, headerImageView, cardInfoButtonsStackView].forEach({containerView.addSubview($0)})
        cardInfoButtonsStackView.mydelegate = self
        
        let constraints = [
            headerImageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            headerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            headerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/7)),
            
            cardInfoButtonsStackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 15),
            cardInfoButtonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            cardInfoButtonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            cardInfoButtonsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/15)),
            
            tableView.topAnchor.constraint(equalTo: cardInfoButtonsStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: private helper functions
    fileprivate func playSound(fileName: String) {
        let sound = Bundle.main.path(forResource: fileName, ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer.play()
        } catch {
            print("Can not dial: \(error)")
        }
    }

    //MARK: Delegate Functions
    func openSupportMessages() {
        self.navigationController?.pushViewController(SupportMessagesCollectionViewController(), animated: true)
    }
    
    func callSupport() {
        let phoneCallView = UIImageView(image: #imageLiteral(resourceName: "supportCallScreen"))

        view.addSubview(phoneCallView)
        phoneCallView.contentMode = .scaleAspectFit
        phoneCallView.frame = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
        
        UIView.animate(withDuration: 0.2) {
            phoneCallView.frame = self.view.frame
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.playSound(fileName: "dialing")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 + 3) {
            self.playSound(fileName: "supportCall")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 + 3 + 12.5) {
            self.audioPlayer.stop()
            phoneCallView.removeFromSuperview()
        }
    }
    
    func openSupportWebsite() {
        let urlString = "https://support.apple.com"
        let url = NSURL(string: urlString)! as URL
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
}

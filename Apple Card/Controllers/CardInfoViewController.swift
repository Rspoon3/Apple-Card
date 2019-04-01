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
    
    var audioPlayer = AVAudioPlayer()

    
    func openSupportMessages() {
        self.navigationController?.pushViewController(SupportMessagesCollectionViewController.init(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
    }
    
    fileprivate func playSound(fileName: String) {
        let sound = Bundle.main.path(forResource: fileName, ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer.play()
        } catch {
            print("Can not dial: \(error)")
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = CardInfoTableView(frame: view.frame, style: .grouped)
        let headerImageView = CardInfoTopImageView(frame: view.frame)
        let cardInfoButtonsStackView = CardInfoButtonsStackView(frame: view.frame)
        
        navigationController?.navigationBar.topItem?.title = ""
        view.addSubview(tableView)
        view.addSubview(headerImageView)
        view.addSubview(cardInfoButtonsStackView)
        view.backgroundColor = UIColor.bgColor
        cardInfoButtonsStackView.mydelegate = self
        
        let constraints = [
            headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/7)),
            
            cardInfoButtonsStackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 15),
            cardInfoButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardInfoButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardInfoButtonsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/15)),
            
            tableView.topAnchor.constraint(equalTo: cardInfoButtonsStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

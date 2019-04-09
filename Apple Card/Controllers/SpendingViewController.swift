//
//  SpendingViewController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/6/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class SpendingViewController: UIViewController{
    
    var mainTransactions : [Transaction] = []
    
    let transactions = [
        Transaction(title: "Shopping", city: "6 Transactions", state: nil, date: "", price: 221.98, logo: #imageLiteral(resourceName: "weekly spending copy 3") , heroImage: #imageLiteral(resourceName: "weekly spending copy"), category: "Shopping"),
        Transaction(title: "Food & Drink", city: "6 Transactions", state: nil, date: "", price: 150.90, logo: #imageLiteral(resourceName: "weekly spending copy") , heroImage: #imageLiteral(resourceName: "weekly spending copy"), category: "Shopping"),
        Transaction(title: "Grocerys", city: "3 Transactions", state: nil, date: "", price: 195.98, logo: #imageLiteral(resourceName: "icons8-shopping-cart-filled-50-2") , heroImage: #imageLiteral(resourceName: "icons8-shopping-cart-filled-50-2"), category: "Shopping"),
        Transaction(title: "Enetertainment", city: "4 Transactions", state: nil, date: "", price: 52.98, logo: #imageLiteral(resourceName: "icons8-party-filled-50-3") , heroImage: #imageLiteral(resourceName: "icons8-party-filled-50-3"), category: "Shopping"),
        Transaction(title: "Gas", city: "5 Transactions", state: nil, date: "", price: 44.98, logo: #imageLiteral(resourceName: "icons8-gas-station-filled-50-3") , heroImage: #imageLiteral(resourceName: "icons8-gas-station-filled-50-3"), category: "Shopping"),
        Transaction(title: "Clothing", city: "2 Transactions", state: nil, date: "", price: 20.99, logo: #imageLiteral(resourceName: "icons8-t-shirt-filled-50-2") , heroImage: #imageLiteral(resourceName: "icons8-t-shirt-filled-50-2"), category: "Shopping"),
    ]

    let scrollView = UIScrollView()
    let cellID = "SpendingViewController"
    let chartView = BaseView()
    let padding : CGFloat = 20
    lazy var collectionView = ChartCollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout(), padding: padding)
    lazy var tableView = CardInfoTableView(frame: view.frame, style: .grouped)
    lazy var bottomView = BottomView(frame: view.frame)

    let chart : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "weekly spending copy-1")
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    lazy var custuomBarButton : UIButton = {
        let button = UIButton(type: .system)
        button.sizeToFit()
        button.setTitle("View Monthly", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.payButton.addTarget(self, action: #selector(presentPaymentScreen), for: .touchUpInside)
        navigationItem.rightBarButtonItem = .init(customView: custuomBarButton)
        bottomView.text = "February Balance"
        bottomView.amount = 687.81
        bottomView.payButton.isHidden = false
        view.backgroundColor = .bgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(TransactionCell.self, forCellReuseIdentifier: cellID)
        
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        
        scrollView.addSubview(collectionView)
        scrollView.addSubview(tableView)
        scrollView.fillSafeSuperview(safeTop: true, safeBottom: false, safeLeading: false, safeTrialing: false)
        
        
        collectionView.anchor(top: scrollView.topAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: nil, size: .init(width: view.frame.width, height: 225 + 50 + 5))
        
        tableView.anchor(top: collectionView.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: nil, constant: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: view.frame.width - 2 * padding, height: 0))
        
        bottomView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: view.frame.height * (1/6)))
    }
    
    @objc func presentPaymentScreen(){
        present(PaymentViewController(), animated: true, completion: nil)
    }

    override func viewWillLayoutSubviews() {
        let tableHeight = 44.0 * 1.9 * Double(transactions.count) + 260
        tableView.anchor(top: nil, bottom: scrollView.bottomAnchor, leading: nil, trailing: nil, size: CGSize(width: 0, height: tableHeight))
    }
    
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let item = self.collectionView.dates.count - 1
            let index : IndexPath = IndexPath(item: item, section: 0)
            self.collectionView.scrollToItem(at: index, at: .right, animated: false)
        }
        
    }
    

}

extension SpendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return transactions.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let title = UILabel()
        
       if section == 0 {
            return nil
        }else {
            let rightText = UILabel()
    
            container.sizeToFit()
            
            title.font = UIFont.boldSystemFont(ofSize: 25)
            title.sizeToFit()
            title.text = "Categories"
            
            rightText.font = UIFont.systemFont(ofSize: 15)
            rightText.sizeToFit()
            rightText.text = "Show Merchants"
            rightText.textColor = container.tintColor
            
            container.addSubview(title)
            container.addSubview(rightText)
            
            title.anchor(top: container.topAnchor, bottom: container.bottomAnchor, leading: container.leadingAnchor, trailing: nil)
            rightText.anchor(top: container.topAnchor, bottom: container.bottomAnchor, leading: nil, trailing: container.trailingAnchor)
        }
        return container
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TransactionCell
        let cornerRadius: CGFloat = 10
        
        cell.dailyCashPercentage.isHidden = true
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        if indexPath.section == 0{
            cell.transaction = Transaction(title: "Daily Cash", city: "17 Transactions", state: nil, date: "", price: 14.99, logo: #imageLiteral(resourceName: "dailyCash") , heroImage: #imageLiteral(resourceName: "weekly spending copy"), category: "Daily Cash")
        } else {
            cell.transaction = transactions[indexPath.row]
            switch indexPath.row {
            case 2:
                cell.imageView?.backgroundColor = UIColor.Apple.blue
            case 3:
                cell.imageView?.backgroundColor = UIColor.Apple.green
            case 4:
                cell.imageView?.backgroundColor = UIColor.Apple.purple
            default:
                cell.imageView?.backgroundColor = UIColor.Apple.red
            }
        }
    
        
       if indexPath.section == 1{
            if indexPath.row == 0{
                cell.roundTopCorners(radius: cornerRadius)
            } else if indexPath.row == transactions.count - 1{
                cell.roundBottomCorners(radius: cornerRadius)
            }
        }
        
        
        if (indexPath.section == 1 && indexPath.row != transactions.count - 1){
            let mySeperator = UIView()
            mySeperator.backgroundColor = tableView.separatorColor
            cell.addSubview(mySeperator)
            mySeperator.anchor(top: nil, bottom: cell.bottomAnchor, leading: cell.leadingAnchor, trailing: cell.trailingAnchor, constant: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 0.3))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 * 1.9
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
            //not perfect but hey it's only a demo ¯\_(ツ)_/¯
            var dates = [String]()
            for i in 0..<collectionView.visibleCells.count{
                if let text = (collectionView.visibleCells[i] as! ChartCell).monthLabel.text{
                    if text != ""{
                        dates.append(text)
                    }
                }
            }
                        
            let destinationVC = DailyCashController()
            destinationVC.transactions = mainTransactions
            destinationVC.bottomTitle = dates.first
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

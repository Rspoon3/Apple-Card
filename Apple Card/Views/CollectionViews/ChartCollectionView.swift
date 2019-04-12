//
//  ChartCollectionView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/7/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class ChartCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var padding : CGFloat!
    let cellID = "ChartUICollectionView"
    let dates = [
        "",
        "March 4 - 10",
        "March 11 - 17",
        "March 18 - 24",
        "",
        ]

    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, padding : CGFloat) {
        self.padding = padding
        super.init(frame: frame, collectionViewLayout: layout)
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = padding * 0.5
        }
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 99999999)
        register(ChartCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChartCell
        if indexPath.item == 0 || indexPath.item == dates.count - 1{
            cell.isHidden = true
        }
        cell.monthLabel.text = dates[indexPath.row]
        cell.roundCorners(radius: 10)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 0, height: frame.height)
        } else if indexPath.item == dates.count - 1{
            return CGSize(width: padding * 0.5, height: frame.height)
        }
        return CGSize(width: frame.width - padding * 2, height: frame.height)
    }
}

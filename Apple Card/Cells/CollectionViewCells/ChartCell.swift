//
//  ChartCell.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/8/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class ChartCell: BaseCollectionViewCell {
    
    var monthLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    
    let chartContainer : BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.roundCorners(radius: 10)
        return view
    }()
    
    let chart : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "weekly spending copy-1")
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    override func setupViews() {
        addSubview(monthLabel)
        addSubview(chartContainer)
        chartContainer.addSubview(chart)
        
        monthLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 50))
        chartContainer.anchor(top: monthLabel.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, constant: .init(top: 5, left: 0, bottom: 0, right: 0))
        chart.fillSuperview()
    }
    
    override func prepareForReuse() {
        isHidden = false
        monthLabel.text = nil
    }
}

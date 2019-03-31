//
//  TableStackView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class TableStackView: UIStackView{
    
    let table = UITableView()
    
    let monthLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.sizeToFit()
        return label
    }()
    
    init(frame: CGRect, table: UITableView, title: String) {
        super.init(frame: frame)
        monthLabel.text = title
        addArrangedSubview(monthLabel)
        addArrangedSubview(table)

        axis = .vertical
        spacing = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

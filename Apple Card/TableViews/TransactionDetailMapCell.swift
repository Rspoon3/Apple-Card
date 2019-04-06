//
//  TransactionDetailMapCell.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit
import MapKit

class TransactionDetailMapCell: UITableViewCell, MKMapViewDelegate {
    static let cellID = "TransactionDetailMapCell"
    var lat = Double.random(in: 41.8...41.92)
    var long = Double.random(in: 87.6...87.65)
    
    var transaction : Transaction?{
        didSet{
            updateCell()
        }
    }
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        let c2D = CLLocationCoordinate2DMake(lat, -long)
        let metersPerMile:Double = 1609.344 / 4
        let myRegion = MKCoordinateRegion(center: c2D, latitudinalMeters: metersPerMile, longitudinalMeters: metersPerMile)
        let annotation = MKPointAnnotation()
        
        
        annotation.title = "Rochester"
        view.setRegion(myRegion, animated: true)
        view.selectAnnotation(annotation, animated: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCell(){
        lat = Double.random(in: 37...49)
        long = Double.random(in: 66...80)
    }
    
    func setupViews(){
      
        addSubview(mapView)
        let constraints = [
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


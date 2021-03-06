//
//  EventMapTableViewCell.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-08-16.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import MapKit
import EasyPeasy

protocol EventMapTableViewCellDataSource: class {
    func mapCenter(in cell: EventMapTableViewCell) -> CLLocationCoordinate2D
    func distance(in cell: EventMapTableViewCell) -> CLLocationDistance
}

protocol EventMapTableViewCellDelegate: class {
    func didSelectOpenMap(cell: EventMapTableViewCell)
}

class EventMapTableViewCell: UITableViewCell, Reusable {

    fileprivate struct Constant {
        static let mapHeight: CGFloat = 260
        static let buttonWidth: CGFloat = 100
    }
    
    weak var dataSource: EventMapTableViewCellDataSource?
    weak var delegate: EventMapTableViewCellDelegate?
    
    lazy var distanceLabel: UILabel     = UILabel.makeLabel(font: AppFont.title, textColor: AppColor.text_dark)
    
    lazy var openMapButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(color: AppColor.brand, for: .normal)
        button.setTitle("Open map", for: .normal)
        button.setTitleColor(AppColor.text_dark, for: .normal)
        button.titleLabel?.font = AppFont.title
        button.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        
        return button
    }()
    
    lazy var mapView: MKMapView = {
        let map                         = MKMapView()
        map.isUserInteractionEnabled    = false
        map.delegate                    = self
        
        return map
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        contentView.addSubview(mapView)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(openMapButton)
        
        mapView <- [
            Edges(),
            Height(Constant.mapHeight)
        ]
        
        distanceLabel <- [
            Top(AppSizeMetric.breathPadding),
            Leading(AppSizeMetric.breathPadding)
        ]
        
        openMapButton <- [
            Width(Constant.buttonWidth),
            Top(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding)
        ]
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let center = dataSource?.mapCenter(in: self) {
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan.defaultMapSpan)
            mapView.setRegion(region, animated: true)
            
            let annotation          = MKPointAnnotation()
            annotation.coordinate   = center
            mapView.addAnnotation(annotation)
        }
        
        if let distance = dataSource?.distance(in: self) {
            distanceLabel.text = distance.readableDescription
        }
    }
    
    @objc
    fileprivate func openMap() {
        delegate?.didSelectOpenMap(cell: self)
    }
}

extension EventMapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.annotation = annotation
        annotationView.image      = UIImage(named: "annotation_active")
        
        return annotationView
    }
}

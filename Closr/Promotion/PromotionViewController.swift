//
//  PromotionViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-09-10.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import MapKit
import EasyPeasy

class PromotionViewController: UIViewController {

    fileprivate lazy var mapView: MKMapView = {
        let map         = MKMapView()
        map.delegate    = self
        
        return map
    }()
    
    fileprivate lazy var zoomInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.setBackgroundColor(color: .white, for: .normal)
        button.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var zoomOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.setBackgroundColor(color: .white, for: .normal)
        button.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var carouselController: PromotionCarouselController = {
        let controller          = PromotionCarouselController()
        controller.delegate     = self
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(carouselController)
        view.addSubview(carouselController.view)
        carouselController.didMove(toParentViewController: self)
        
        view.addSubview(mapView)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        
        createConstraints()
    }
    
    fileprivate func centerMapTo(item: Int) {
        let annotations = mapView.annotations
        
        guard annotations.count > item else {
            return
        }
        
        for (index, annotation) in annotations.enumerated() {
            mapView.view(for: annotation)?.image = (index == item) ? UIImage(named: "annotation_active") : UIImage(named: "annotation")
        }

        let region = MKCoordinateRegion(center: annotations[item].coordinate, span: MKCoordinateSpan.defaultMapSpan)
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func createConstraints() {
        mapView <- [
            Top(),
            Leading(),
            Trailing(),
            Height(275)
        ]
        
        zoomInButton <- [
            Size(24),
            Top(AppSizeMetric.breathPadding),
            Trailing(AppSizeMetric.breathPadding)
        ]
        
        zoomOutButton <- [
            Size(24),
            Top(AppSizeMetric.breathPadding).to(zoomInButton),
            Trailing(AppSizeMetric.breathPadding)
        ]
        
        carouselController.view <- [
            Top().to(mapView),
            Leading(),
            Trailing(),
            Bottom()
        ]
    }
    
    @objc
    fileprivate func zoomIn() {
        zoomTo(level: 0.8)
    }
    
    @objc
    fileprivate func zoomOut() {
        zoomTo(level: 1.2)
    }
    
    fileprivate func zoomTo(level: Double) {
        var region = mapView.region
        var span = region.span
        span.latitudeDelta = span.latitudeDelta * level
        span.longitudeDelta = span.longitudeDelta * level
        
        region.span = span
        mapView.setRegion(region, animated: true)
    }
}

extension PromotionViewController: PromotionCarouselControllerDelegate {
    func didScrollTo(item: Int) {
        centerMapTo(item: item)
    }
    
    func didFinishLoading(_ controller: PromotionCarouselController, coordinates: [CLLocationCoordinate2D]) {
        let annotations = coordinates.map { coordinate -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        didScrollTo(item: 0)
    }
}

let kAnnotationReuseIdentifier = "AnnotationView"
extension PromotionViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView      = mapView.dequeueReusableAnnotationView(withIdentifier: kAnnotationReuseIdentifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: kAnnotationReuseIdentifier)
        annotationView.image    = UIImage(named: "annotation")
        
        return annotationView
    }
}

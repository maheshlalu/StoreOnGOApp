
//
//  MapViewCntl.swift
//  StoreOnGoApp
//
//  Created by Rama kuppa on 08/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

import UIKit
import MapKit

class MapViewCntl: UIViewController {
    var mapView: MKMapView = MKMapView ()
    let screenSize = UIScreen.mainScreen().bounds.size
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTheNavigationProperty()
        self.designMapview()

        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTheNavigationProperty(){
        super.viewDidLoad()
        self.title = "WELOCOME TO NV AGENCIES"
        //self.designHeaderView()
        self.navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    func designMapview () {
        
        self.mapView = MKMapView.init(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        self.view.addSubview(self.mapView)
        self.mapView.delegate = self
        self.zoomToRegion()
        self.addShowDirectionButton()
    }
    
    func addShowDirectionButton () {
        let showDirectionBtn : UIButton = UIButton.init(frame: CGRectMake(0, 0, 250, 70))
        self.mapView.addSubview(showDirectionBtn)
        showDirectionBtn.setTitle("Show Direction", forState: UIControlState.Normal)
        showDirectionBtn.titleLabel?.textColor = UIColor.whiteColor()
        showDirectionBtn.backgroundColor = CXConstant.homeCellBgColor
        showDirectionBtn.center = CGPointMake(screenSize.width/2, screenSize.height-100)
        self.view.bringSubviewToFront(showDirectionBtn)
        showDirectionBtn.addTarget(self, action: #selector(MapViewCntl.showMapDirection), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 18.5184, longitude: 84.1514)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        
        let annotation = Station(latitude: location.latitude, longitude: location.longitude)
        
        mapView.addAnnotation(annotation)
        
        mapView.setRegion(region, animated: true)
    }
    
    func showMapDirection(){
        
        self.showMapPointLocation()
        
    }
    func showMapPointLocation () {
        
        //18.5184° N, 84.1514° E
        
        let lat = 18.5184
        let long = 84.1514
        
        var annotations:Array = [Station]()
        let annotation = Station(latitude: lat, longitude: long)
        annotations.append(annotation)
        
        self.mapView.addAnnotation(annotation)
        
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        
        for annotation in annotations {
            points.append(annotation.coordinate)
        }
        
        
        let polyline = MKPolyline(coordinates: &points, count: points.count)
        
        mapView.addOverlay(polyline)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewCntl :MKMapViewDelegate,CLLocationManagerDelegate {
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        if overlay is MKPolyline {
            polylineRenderer.strokeColor = UIColor.redColor()
            polylineRenderer.lineWidth = 5
            
        }
        return polylineRenderer
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}


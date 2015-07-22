//
//  ViewController.swift
//  MyLocation
//
//  Created by Karol Tyde on 21/07/15.
//  Copyright © 2015 Karol Tyde. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var LatitudeLabel: UILabel!
    @IBOutlet weak var LongitudeLabel: UILabel!
    @IBOutlet weak var AltitudeLabel: UILabel!
    
    var LocationManager: CLLocationManager!
    
    var location: CLLocation! {
        didSet {
            LatitudeLabel.text = "\(location.coordinate.latitude)"
            LongitudeLabel.text = "\(location.coordinate.longitude)"
            AltitudeLabel.text = "\(location.altitude)"
        }
    }
    
    
    
    @IBAction func updateLocation(sender: AnyObject) {
        LocationManager.startUpdatingLocation()
    }
 
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        LocationManager = CLLocationManager()
        LocationManager.delegate = self
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()

    }
    
    func checkCoreLocationPermission() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            LocationManager.startUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .NotDetermined {
            LocationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .Restricted {
            //don'thave permission to use GPS
            print("Unauthorized to use location service")
            
        }
        
    }
    //CLLocation Manage
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = (locations as [CLLocation]).last
        LocationManager.stopUpdatingLocation() //save battery
    }


}

 
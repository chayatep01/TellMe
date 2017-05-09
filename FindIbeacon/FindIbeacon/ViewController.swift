//
//  ViewController.swift
//  FindIbeacon
//
//  Created by chayatep on 5/9/2560 BE.
//  Copyright © 2560 chayatep. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController:  UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var objectStatus: UILabel!
    var locationManager:CLLocationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    
    func rangeBeacons(){
        
        print("1111111")
        let uuid = UUID(uuidString: "622655B2-1B07-452B-BE55-766E3DB29728")
        
        print("2222222")
        let major:CLBeaconMajorValue = 5
        print("3333333")
        let minor:CLBeaconMinorValue = 4
        print("4444444")
        let identifier = "candy"
        print("555555555")
        
        let region : CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: major, minor: minor, identifier: identifier)
        
        print("66666666")
        locationManager.startRangingBeacons(in: region)
        print("777777777")
    }
    
    // MARK : Location Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways{
            print("start range beacons")
            //User has authorized the application - range those beacons!
            rangeBeacons()
            print("stop range beacons")
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        guard let discoverdBeaconProximity = beacons.first?.proximity else { print("Couldn't find the beacon!"); return }
        
        print("find beacon")
        print(discoverdBeaconProximity )
        /*
        let backgroundColour:UIColor =  {
            
            switch discoverdBeaconProximity {
                
                case.immediate: return UIColor.green
                case.near: return UIColor.orange
                case.far: return UIColor.red
                case.unknown: return UIColor.black
            }
        }()
        */
        switch discoverdBeaconProximity {
            
        case.immediate: view.backgroundColor = UIColor.green; objectStatus.text="ใกล้มาก" ; return
        case.near: view.backgroundColor = UIColor.orange;objectStatus.text="ใกล้" ;return
        case.far: view.backgroundColor = UIColor.red; objectStatus.text="ไกล"  ; return
        case.unknown: view.backgroundColor = UIColor.black ;objectStatus.text="ยังไม่เจอ" ; return
        }
        
        
        
    }
    
    



}


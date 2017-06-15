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
    @IBOutlet var ObjectStatus: UILabel!
    
    
    class Location{
        
        
        private var title:String;
        private var message:String;
        private var major: NSNumber;
        private var minor: NSNumber;
        private var uuid: UUID;
        private var status : Bool;
        
        
        init(title:String, message:String, major:NSNumber , minor:NSNumber , uuid: UUID) {
            
            self.title = title;
            self.message = message;
            self.major = major;
            self.minor = minor;
            self.uuid = uuid;
            self.status = true;
            
        }
        
        public func getTtile() -> String{
        
            return self.title;
        
        }
        
        public func getMessage() -> String{
        
            return self.message;
            
        }
        
        public func getMajor() -> NSNumber{
        
            return self.major;
            
        }
        
        public func getMinor() -> NSNumber{
        
            return self.minor;
        
        }
        
        public func getUUID() -> UUID{
        
            return self.uuid;
            
        }
        
        public func getStatus() -> Bool{
        
            return self.status;
            
        }
        
        public func setStatus(status:Bool){
        
            self.status = status;
            
        }
        
        
        
    }
    
    
    var locationManager:CLLocationManager = CLLocationManager();
    var listLocation = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        listLocation.append(Location(title: "รถ ngv สายสามมาถึงแล้วนะ",message: "เดินทางโดยสวัสดีภาพ", major: 1 as NSNumber, minor: 2 as NSNumber, uuid: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!));
        listLocation.append(Location(title: "รถ ngv สายสามมาถึงแล้วนะ",message: "ทานกับข้าวให้อร่อย", major: 1 as NSNumber, minor: 4 as NSNumber, uuid: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!));
        
        /*
         switch discoverdBeaconProximity {
         
         case.immediate: createAlert(title: "ถึงร้านข้าวขาหมูแล้ว", massage:  "เดินทางโดยสวัสดีภาพ");objectStatus.text="ใกล้มาก";return;
         case.near: objectStatus.text="ใกล้" ;return
         case.far:  objectStatus.text="ไกล"  ; return
         case.unknown: objectStatus.text="ยังไม่เจอ" ; return
         
         }
         
         switch discoverdBeaconProximity {
         
         case.immediate: createAlert(title: "ถึงร้านข้าวแล้ว", massage:  "ทานกับข้าวให้อร่อย");otherobjectStatus.text="ใกล้มาก";return;
         case.near: otherobjectStatus.text="ใกล้" ;return
         case.far:  otherobjectStatus.text="ไกล"  ; return
         case.unknown: otherobjectStatus.text="ยังไม่เจอ" ; return
         
         }
         */
        
        //Location(title: "test",message: "test", major: 1 as NSNumber, minor: 2 as NSNumber)
    }
    func createAlert (title:String ,massage:String)
    {
        let alert = UIAlertController(title:title , message:massage,preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title:"OK" , style:UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated:true ,completion:nil)}))
        self.present(alert,animated: true,completion: nil)
    }
    

    
    
    func rangeBeacons(){
        
        
        let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
        
        var major:CLBeaconMajorValue = 1
        var minor:CLBeaconMinorValue = 2
        var identifier = "beetroot"
        let region1 : CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: major, minor: minor, identifier: identifier)
        major = 1;
        minor = 4;
        identifier = "candy";
        let region2 : CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: major, minor: minor, identifier: identifier)
        
        locationManager.startRangingBeacons(in: region1)
        locationManager.startRangingBeacons(in: region2)
        
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
        
        var knowBeacons = beacons.filter{ $0.proximity != CLProximity.unknown };
        
        if(knowBeacons.count > 0){
        
            let closestBeacon = knowBeacons[0] as CLBeacon;

            for location in self.listLocation{
                
                if(location.getMajor() == closestBeacon.major && location.getMinor() == closestBeacon.minor && location.getUUID() == closestBeacon.proximityUUID){
                    
                    switch closestBeacon.proximity {
                        
                    case.immediate: if(location.getStatus()){createAlert(title: location.getTtile(), massage: location.getMessage());ObjectStatus.text=location.getTtile() + "ใกล้มาก"; location.setStatus(status: false)};return;
                    case.near: ObjectStatus.text="ยังไม่เจอ";location.setStatus(status: true);return
                    case.far:  ObjectStatus.text="ยังไม่เจอ"; location.setStatus(status: true);return
                    case.unknown: ObjectStatus.text="ยังไม่เจอ"; location.setStatus(status:true);return
                        
                    }
                
                }
                
            }
        }

        /*
        guard let discoverdBeaconProximity = beacons.first?.proximity else { print("Couldn't find the beacon!"); return }
        */
        
        //print("find beacon")
        //print(discoverdBeaconProximity )
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
        /*
        switch discoverdBeaconProximity {
            
        case.immediate: view.backgroundColor = UIColor.green;createAlert(title: "รถมาถึงแล้ว", massage:  "เดินทางโดยสวัสดีภาพ");objectStatus.text="ใกล้มาก";return
        case.near: view.backgroundColor = UIColor.orange;objectStatus.text="ใกล้" ;return
        case.far: view.backgroundColor = UIColor.red; objectStatus.text="ไกล"  ; return
        case.unknown: view.backgroundColor = UIColor.black ;objectStatus.text="ยังไม่เจอ" ; return
        
        }
        */
               
    }
    



}


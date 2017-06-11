import { Component, ChangeDetectorRef } from '@angular/core';
import { NavController,Platform } from 'ionic-angular';
import { BLE } from "@ionic-native/ble";
import { EstimoteBeacons ,EstimoteBeaconRegion} from '@ionic-native/estimote-beacons';
declare var evothings: any;

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
  nearByPlaces : any;
  constructor(private change:ChangeDetectorRef,public navCtrl: NavController,private platform: Platform,private eb: EstimoteBeacons) {
    this.nearByPlaces = [

        {
          name : "ร้านขาหมูนายตี๋",
          distance : 10,
          ibeacon : "FC:41:65:72:7F:66",
          last : false
        },
        {
          name : "ร้านน้ำปั่น",
          distance : -1,
          ibeacon : "F3:A9:BF:29:04:E9",
          last : false
        },
        {
          name : "ระวัง(สถานที่ก่อสร้าง)",
          distance : -1,
          ibeacon : "F3:A9:BF:29:04:E9",
          last: true
        }
      

      ];
      this.startScanIBeacon();
  }
  
  startScanIBeacon(){
    this.platform.ready().then(() => { 
       evothings.eddystone.startScan((data) =>{
         
        for(var i = 0 ; i < this.nearByPlaces.length ; i++){
          if (data.address === "FC:41:65:72:7F:66" ){
              let distance = Math.pow(10 , (data.txPower - data.rssi)/20);
              this.nearByPlaces[0].distance = Math.round(distance/100);
              break;
          }
          if (data.address === "F3:A9:BF:29:04:E9" ){
              let distance = Math.pow(10 , (data.txPower - data.rssi)/20);
              this.nearByPlaces[1].distance = Math.round(distance/100); 
              break;
          }
        }

        
  
        /*
        let distance = Math.pow(10 , (data.txPower - data.rssi)/20);
        this.nearByPlaces[0].distance = Math.round(distance/100);
        console.log(distance);
        */

        setTimeout(() => {
          this.change.detectChanges();
        },5000);
      }, error => console.error(error));
    })    
  }


}

import { Component,ChangeDetectorRef } from '@angular/core';
import { Platform } from 'ionic-angular';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  beaconData: any;
  nearByPlaces : any;
  nearByFacility : any;

  constructor(private change:ChangeDetectorRef,private platform:Platform) {
      //"F3:A9:BF:29:04:E9" purple
      //"FC:41:65:72:7F:66" pink
      //d = 10 ^ ((TxPower - RSSI) / 20)
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
      

      ]

      this.nearByFacility = [

        {
          name : "ห้องน้ำ",
          distance : 6,
          last : false
        },
        {
          name : "ร้านสะดวกซื้อ",
          distance : 10,
          last: true
        }

      ]


    this.platform.ready().then(()=>{
      evothings.eddystone.startScan((data) =>{
        this.beaconData = data;
        console.log(this.beaconData)
        let distance = Math.pow(10 , (this.beaconData.txPower - this.beaconData.rssi)/20);
        this.nearByPlaces[0].distance = Math.round(distance/100);
        console.log(distance);
        

        setTimeout(() => {
          this.change.detectChanges();
        },1000);
      }, error => console.error(error));
    })

  }
 



}
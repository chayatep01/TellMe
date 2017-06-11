import { Component,ChangeDetectorRef , ViewChild} from '@angular/core';
import { Platform } from 'ionic-angular';
import { Geolocation } from '@ionic-native/geolocation';
import { Slides } from 'ionic-angular';
import {
 GoogleMaps,
 GoogleMap,
 GoogleMapsEvent,
 LatLng,
 CameraPosition,
 MarkerOptions,
 Marker
} from '@ionic-native/google-maps';
import { HTTP } from '@ionic-native/http';
import { NativeGeocoder, NativeGeocoderReverseResult, NativeGeocoderForwardResult } from '@ionic-native/native-geocoder';

declare var evothings: any;

declare var google: any;
@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
  @ViewChild(Slides) slides: Slides;
  beaconData: any;
  nearByPlaces : any;
  nearByFacility : any;
  locationName : String;
  constructor(private change:ChangeDetectorRef ,private platform:Platform ,private geolocation: Geolocation, private http : HTTP , private nativeGeocoder: NativeGeocoder) {
      
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
    


      //"F3:A9:BF:29:04:E9" purple
      //"FC:41:65:72:7F:66" pink
      //d = 10 ^ ((TxPower - RSSI) / 20)

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
 
  slideChanged() {
    let currentIndex = this.slides.getActiveIndex();
    console.log("Current index is", currentIndex);
  }



}
import { Component } from '@angular/core';
import { NavController,Platform } from 'ionic-angular';
import { BLE } from "@ionic-native/ble";

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  constructor(public navCtrl: NavController,private platform: Platform,private ble: BLE) {
    
  }

  pScan() {
    this.platform.ready().then(() => { 
      this.ble.scan([],5).subscribe(device => {
       console.log(device);
      });
    })
  }

}

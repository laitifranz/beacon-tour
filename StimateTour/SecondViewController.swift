//
//  SecondViewController.swift
//  StimateTour
//
//  Created by Francesco Laiti on 12/11/17.
//  Copyright © 2017 francescolaiti. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var infoSender = 0

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var info: UIButton!
    @IBOutlet var mappa: MKMapView!
    @IBOutlet var attualeZona: UILabel!
    @IBOutlet weak var beaconName: UILabel!
    
    var controllo = 0
    var controllo1 = 0
    let locationManager = CLLocationManager()
//    let region = CLBeaconRegion(proximityUUID: NSUUID (uuidString: "83E8D0D2-6599-4196-BDC7-2887937200F1")! as UUID, identifier: "beaconTarallo")
    let region = CLBeaconRegion(proximityUUID: NSUUID (uuidString: codiceRegione)! as UUID, identifier: "virtualBeacon")
    
    var posizione = CLLocationCoordinate2DMake(posizioneX[000]!, posizioneY[000]!)
    let annotazione = MKPointAnnotation()
    let spanna = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001) //di quanto deve azoomare per raggiungere l'obiettivo 'annotazione'
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        attualeZona.text = ""
        info.isEnabled = false
        info.layer.cornerRadius = 8
        
        locationManager.stopMonitoring(for: region) //killo ogni tipo di scansione beacon
        locationManager.startRangingBeacons(in: region) //inizio a scandaglaire per i beacon
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startRangingBeacons(in: region) //inizio a scandaglaire per i beacon
        
    }
    
//funzioni
    
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity == CLProximity.immediate } //.immediate significa che il beacon è nelle immediate vicinanze. vedere guida online per cambiare valore
        print(knownBeacons)
        if (knownBeacons.count > 0) {
                info.isEnabled = true
                info.setTitle(NSLocalizedString("info_button", comment: ""), for: .normal)
                let closestBeacon = knownBeacons[0] as CLBeacon
                attualeZona.text = luogo[closestBeacon.minor.intValue]

                //            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                annotazione.title = luogo[closestBeacon.minor.intValue]
                infoSender = closestBeacon.minor.intValue //aggiornare variabile per infoview
                posizione = CLLocationCoordinate2DMake(posizioneX[closestBeacon.minor.intValue] ?? posizioneX[000]!, posizioneY[closestBeacon.minor.intValue] ?? posizioneY[000]!)
                annotazione.coordinate = posizione
                mappa.addAnnotation(annotazione)
                mappa.setRegion(MKCoordinateRegion(center: posizione, span: spanna), animated: true)
    //            print("entrato vicino")
                
                controllo1 = 0 //riduce lavoro a cpu, basso impatto energetico
            
            
                beaconName.text = String(closestBeacon.minor.intValue) //nome del beacon
        }

        else if (beacons == []){ //non trova beacon nell'area
            if controllo == controllo1 { //riduce lavoro, basso impatto energetico per refreshare uguale pagina
                info.isEnabled = false
                info.setTitle(NSLocalizedString("beacon_find", comment: ""), for: .normal)
                attualeZona.text = "-"
    //            mappa.removeAnnotation(annotazione)
                annotazione.title = "Scuole Alle Stimate"
                posizione = CLLocationCoordinate2DMake(posizioneX[000]!, posizioneY[000]!)
                annotazione.coordinate = posizione
                mappa.addAnnotation(annotazione)
                mappa.setRegion(MKCoordinateRegion(center: posizione, span: spanna), animated: true)
            
                controllo1 = 1
//                print("entrato in refresh pagina")
            }
//            print("entrato in beacon vuoti")
        }

        else {
            let knowBeaconLontano = beacons.filter{ $0.proximity == CLProximity.near }
                if (knowBeaconLontano.count > 0){
                    let beaconRilevato = knowBeaconLontano[0] as CLBeacon
                    attualeZona.text = NSLocalizedString("trovato", comment: "") + " " + "\(luogo[beaconRilevato.minor.intValue] ?? NSLocalizedString("place", comment: ""))"
                    //            info.setTitle("Avvicinati", for: .normal)
                    info.isEnabled = false
                    info.setTitle(NSLocalizedString("vicino", comment: ""), for: .normal)
                    annotazione.title = luogo[beaconRilevato.minor.intValue]
                    posizione = CLLocationCoordinate2DMake(posizioneX[beaconRilevato.minor.intValue] ?? posizioneX[000]!, posizioneY[beaconRilevato.minor.intValue] ?? posizioneY[000]!)
                    annotazione.coordinate = posizione
                    mappa.addAnnotation(annotazione)
                    mappa.setRegion(MKCoordinateRegion(center: posizione, span: spanna), animated: true)
                }
                else {
                    info.isEnabled = false
                    info.setTitle(NSLocalizedString("beacon_find", comment: ""), for: .normal)
                    attualeZona.text = "-"
                    //            mappa.removeAnnotation(annotazione)
                    annotazione.title = "Scuole Alle Stimate"
                    posizione = CLLocationCoordinate2DMake(posizioneX[000]!, posizioneY[000]!)
                    annotazione.coordinate = posizione
                    mappa.addAnnotation(annotazione)
                    mappa.setRegion(MKCoordinateRegion(center: posizione, span: spanna), animated: true)
                }
            
                controllo1 = 0
        }

        print(beacons) //solo per osservare i vari beacon da terminale Xcode

    }
    
    @IBAction func passaggioView(_ sender: Any) {
        locationManager.stopRangingBeacons(in: region)

    }

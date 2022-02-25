//
//  ViewController.swift
//  StimateTour
//
//  Created by Francesco Laiti on 12/11/17.
//  Copyright © 2017 francescolaiti. All rights reserved.
//

//PER AGGIUNGERE LINGUE BISOGNA AGGIUNGERLE DALLE IMPOSTAZIONI DEL PROGETTO
//PER FAR CAMBIARE UNA STRINGA BISOGNA AGGIUNGERE  NSLocalizesString("nome_valore_univoco", comment:"")
//AGGIUNGERE A FILE Localizable.string (lingua):
//nome_valore_univoco = "traduzione stringa";
//se risulta errore controllare che alla fine di ogni stringa ci sia ';'


import UIKit
import CoreLocation
import UserNotifications
import CoreBluetooth

var check = 0
var check1 = 0

class ViewController: UIViewController, CLLocationManagerDelegate, CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            check1 = 1
            btButton.setTitleColor(UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.0), for: .normal)
            btButton.isEnabled = false
            avvio()
        }
        else if central.state == .poweredOff {
            btButton.setTitleColor(UIColor.red, for: .normal)
        }
        else {
            createAlert(title: NSLocalizedString("bluetooth_error", comment: ""), message: NSLocalizedString("bt_error_desc", comment: ""))
        }

    }
    
    var manager: CBCentralManager!
    
    @IBAction func bluetoothButton(_ sender: Any) {
        createAlert(title: NSLocalizedString("active_bt", comment: "attiva"), message: NSLocalizedString("active_bt_desc", comment: "attiva description"))
    }
    
    @IBAction func localButton(_ sender: Any) {
        createAlert(title: NSLocalizedString("loc_alw", comment: "loc always"), message: NSLocalizedString("loc_alw_desc", comment: "always descrip"))
    }
    
    @IBAction func WebLink(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Link Internet", message: NSLocalizedString("reindirizzamento", comment: "link internet"), preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Alle Stimate - Youtube", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            if let url = NSURL(string: "https://www.youtube.com/user/scuolestimate") {
                UIApplication.shared.open(url as URL, completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Science Stimate - Youtube", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            if let url = NSURL(string: "https://www.youtube.com/channel/UCTdaNss2xbwaZYASm2kvPzQ") {
                UIApplication.shared.open(url as URL, completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("web", comment: "sito web"), style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            if let url = NSURL(string: "http://www.scuolestimate.it") {
                UIApplication.shared.open(url as URL, completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancella", comment: "cancella"), style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBOutlet var lzButton: UIButton!
    @IBOutlet var btButton: UIButton!
    @IBOutlet var startTour: UIButton!
    @IBOutlet var immagine: UIImageView!
    @IBOutlet var sitoWeb: UIButton!
    @IBOutlet var background: UIButton!
    
    
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore") //per determinare il primo lancio dell'applicazione
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        startTour.isEnabled = false
        immagine.layer.cornerRadius = 15
        startTour.layer.cornerRadius = 8
        sitoWeb.layer.cornerRadius = 8
        background.layer.cornerRadius = 8
        locationManager.requestAlwaysAuthorization()
        manager = CBCentralManager()
        manager.delegate = self
        
        lzButton.setTitleColor(UIColor.red, for: .normal)

        backgroundColours = [UIColor.orange, UIColor.green, UIColor.yellow,UIColor.red]
        backgroundLoop = 0
        self.animateBackgroundColour()
        
    }

//TUTTE FUNZIONI

//    creazione di popup di avviso a schermo
    func createAlert(title:String, message:String){

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("open_set", comment: "open set"), style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            self.apriImpostazioni()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancella", comment: "cancella"), style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))

        self.present(alert, animated: true, completion: nil)
    }
    
    //aprire il settings
    func apriImpostazioni(){
        let url = URL(string: UIApplication.openSettingsURLString) //aprire impostazioni app su Impostazioni
        UIApplication.shared.open(url!, completionHandler: nil)
    }
    
    
    //controllo localizzazione
    func localizzazioneAttivazione(){
        
        if CLLocationManager.locationServicesEnabled(){
            if (CLLocationManager.authorizationStatus() == .authorizedAlways){
                lzButton.setTitleColor(UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.0), for: .normal)

                lzButton.isEnabled = false

                check = 1
                avvio()
            }
            else if ((CLLocationManager.authorizationStatus() == .authorizedWhenInUse))  {
                locationManager.requestAlwaysAuthorization()
                lzButton.setTitleColor(UIColor.red, for: .normal)
                if launchedBefore  {    //per determinare il primo lancio dell'applicazione
//                    print("Not first launch.")
                    createAlert(title: NSLocalizedString("loc_alw", comment: "loc always"), message: NSLocalizedString("loc_whenInUse", comment: "description local"))
                } else {
//                    print("First launch, setting UserDefault.")
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                }
                
            }
                
            else if ((CLLocationManager.authorizationStatus() == .notDetermined) || (CLLocationManager.authorizationStatus() == .denied) || (CLLocationManager.authorizationStatus() == .restricted)) {
                lzButton.setTitleColor(UIColor.red, for: .normal)
                if launchedBefore {
                    createAlert(title: NSLocalizedString("loc_alw", comment: "loc always"), message: NSLocalizedString("loc_Restricted", comment: "impreciso localizzazione"))
                } else {
//                    print("First launch, setting UserDefault.")
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                }
            }
        }
        else {
            createAlert(title: NSLocalizedString("loc_off", comment: "loc non funziona"), message: NSLocalizedString("loc_off_desc", comment: "descrpirion"))
        }
    }
    
    
    func avvio(){
        if check == check1 {
            startTour.isEnabled = true
        }
    }
    
    
        func animateBackgroundColour () {
            if backgroundLoop < backgroundColours.count - 1 {
                backgroundLoop = backgroundLoop + 1
            } else {
                backgroundLoop = 0
            }
            UIView.animate(withDuration: 3, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
                self.view.backgroundColor =  self.backgroundColours[self.backgroundLoop];
            }) {(Bool) -> Void in
                self.animateBackgroundColour();
            }
        }
    
    @IBAction func inizioTourPulsante(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    @IBAction func infoApp(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString("info", comment: "info"), message: NSLocalizedString("info_desc", comment:""), preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("close", comment: ""), style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
    





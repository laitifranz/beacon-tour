//
//  Info-ViewController.swift
//  StimateTour
//
//  Created by Francesco Laiti on 12/11/17.
//  Copyright © 2017 francescolaiti. All rights reserved.
//

import UIKit
import AVFoundation

class Info_ViewController: UIViewController {
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var timer = Timer()
    var photoCount = 0
    var primaImmagine:[String] = []
    
    @IBOutlet var immagine: UIImageView!
    @IBOutlet var startStop: UISegmentedControl!
    @IBOutlet var zonaDisplay: UILabel!
    @IBOutlet var spiego: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        zonaDisplay.text = luogo[infoSender]
//        spiegazione.text = descrizione[infoSender]
//        immagine.image = UIImage(named: immagineDisplay[infoSender]!)
        zonaDisplay.text = luogo[infoSender] ?? luogo[000]
        spiego.text = descrizione[infoSender] ?? descrizione[000]
        
        primaImmagine = immagineDisplay[infoSender] ?? immagineDisplay[000]!

        timer = Timer.scheduledTimer(timeInterval: 9.0, target: self, selector: #selector(onTransition), userInfo: nil, repeats: true)
        
        immagine.image = UIImage.init(named: primaImmagine[0])
        
//        self.immagine.animationImages = imagesListArray
//        self.immagine.animationDuration = 15
//        self.immagine.startAnimating()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startStopAction(_ sender: Any) 		{
        if startStop.selectedSegmentIndex == 1 {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            myUtterance = AVSpeechUtterance(string: spiego.text!)
            myUtterance.rate = 0.5
//            myUtterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
            synth.speak(myUtterance)
            
        }
        if startStop.selectedSegmentIndex == 0 {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            synth.stopSpeaking(at: .immediate)
        }
    }
    
    @objc func onTransition() {
        if (photoCount < primaImmagine.count - 1){
            photoCount = photoCount  + 1
            }
        else{
            photoCount = 0
            }
        
        UIView.transition(with: self.immagine, duration: 2.0, options: .transitionCrossDissolve, animations: {
            self.immagine.image = UIImage.init(named: "\(self.primaImmagine[self.photoCount])")
        }, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        synth.stopSpeaking(at: .immediate)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

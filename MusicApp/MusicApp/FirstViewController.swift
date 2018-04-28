//
//  FirstViewController.swift
//  MusicApp
//
//  Created by Sunbin Kim on 4/4/18.
//  Copyright © 2018 Sunbin Kim. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    @IBOutlet weak var speedText: UITextField!
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample1", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: Any) {
        audioPlayer.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        } else{
            
        }
    }
    
    @IBAction func restart(_ sender: Any) {
        if audioPlayer.isPlaying{
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else{
            audioPlayer.play()
        }
    }
    
//    func changeSpeed(){
//        if(speedText.text != nil){
//            let alertController = UIAlertController(title: "Input needed", message:
//                "Please put in speed", preferredStyle: UIAlertControllerStyle.alert)
//            alertController.addAction(UIAlertAction(title: "NEW GAME", style: UIAlertActionStyle.default,handler: nil))
//            
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
    
}


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
    
    @IBOutlet weak var musicSlider: UISlider!
    
    @IBOutlet weak var speedText: UITextField!
    
    @IBOutlet weak var startLoop: UITextField!
    
    @IBOutlet weak var endLoop: UITextField!
    
    @IBOutlet weak var loopButton: UIButton!
    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    var loopTimer = Timer()
    var loopBool = false
    var difference = Float(0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample1", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        audioPlayer.play()
        musicSlider.maximumValue = Float(audioPlayer.duration)
        changeTimer()
        
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
    func changeTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(FirstViewController.updateSlider), userInfo: nil, repeats: true)
    }
    
    @IBAction func restart(_ sender: Any) {
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            audioPlayer.play()
            changeTimer()
        } else{
            audioPlayer.play()
        }
        musicSlider.value = 0
    }
    

    @IBAction func speedButton(_ sender: Any) {
        if(speedText.text == nil){
            let alertController = UIAlertController(title: "Input needed", message:
                "Please put in speed", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Input", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            audioPlayer.enableRate = true
            audioPlayer.rate = Float(speedText.text!)!
            audioPlayer.stop()
            changeTimer()
            audioPlayer.play()
        }
    }
    
    @IBAction func changeTime(_ sender: Any) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(musicSlider.value)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    @objc func updateSlider(){
        musicSlider.value = Float(audioPlayer.currentTime)
        NSLog("update Slider working")
    }
    
    @objc func updateLoop(){
        if (difference <= 0) {
            loopTimer.invalidate()
            loopStartEnd()
        } else{
            musicSlider.value = Float(audioPlayer.currentTime)
            NSLog("update Slider working")
            difference -= 0.1
        }
    }
    
    func loopStartEnd(){
        loopTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(FirstViewController.updateLoop), userInfo: nil, repeats: true)
        difference = Float(endLoop.text!)! - Float(startLoop.text!)!
        if(loopBool == true){
            audioPlayer.currentTime = TimeInterval(Float(startLoop.text!)!)
            audioPlayer.play()
        }
    }
    
    @IBAction func loopButtonPressed(_ sender: Any) {
        if (loopBool == false){
            loopBool = true
            loopStartEnd()
            loopButton.setImage(UIImage(named: "stop.png"), for: .normal)
        } else {
            loopBool = false
            loopTimer.invalidate()
            loopButton.setImage(UIImage(named: "loop.png"), for: .normal)
        }
    }
    

    

}


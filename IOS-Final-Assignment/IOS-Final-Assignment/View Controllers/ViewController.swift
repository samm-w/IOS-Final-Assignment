//
//  ViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 3/22/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var volSlider: UISlider!
    var soundPlayer: AVAudioPlayer!
    
    @IBAction func volumeDidChange(sender: UISlider){
        soundPlayer?.volume = volSlider.value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let soundURL = Bundle.main.path(forResource: "song", ofType: "mp3")!
        let url = URL(fileURLWithPath: soundURL)
        self.soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        self.soundPlayer.currentTime = 0
        self.soundPlayer.volume = volSlider.value
        self.soundPlayer.numberOfLoops = -1
        self.soundPlayer.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.soundPlayer.stop()
    }
    
    @IBAction func unwindToHomeVC(sender: UIStoryboardSegue!){}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


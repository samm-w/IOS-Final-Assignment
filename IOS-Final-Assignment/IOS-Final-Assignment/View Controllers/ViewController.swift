//
//  ViewController.swift
//  Principal Author: Sam Whelan
//  Created by  on 3/22/21.
//  Description: The code in the file is create to play music when the user arrives on the app homepage

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    //This variable is connected to the slider on the homepage, which allows you to turn on or off the music that plays by default
    @IBOutlet var volSlider: UISlider!
    //The soundplayer that will play the music when the page loads
    var soundPlayer: AVAudioPlayer!
    
    //This is an event method that will change the volume of the music when the slider is moved
    @IBAction func volumeDidChange(sender: UISlider){
        soundPlayer?.volume = volSlider.value
    }
    
    //This method is for when the view appears, which means the music will start to play
    override func viewWillAppear(_ animated: Bool) {
        let soundURL = Bundle.main.path(forResource: "song", ofType: "mp3")!
        let url = URL(fileURLWithPath: soundURL)
        self.soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        self.soundPlayer.currentTime = 0
        self.soundPlayer.volume = volSlider.value
        self.soundPlayer.numberOfLoops = -1
        self.soundPlayer.play()
    }
    
    //When the main page is no longer the one in focus, this will stop the music from playing
    override func viewDidDisappear(_ animated: Bool) {
        self.soundPlayer.stop()
    }
    
    //An unwinding method for segues to allow the other page's back buttons to send back to homepage
    @IBAction func unwindToHomeVC(sender: UIStoryboardSegue!){}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


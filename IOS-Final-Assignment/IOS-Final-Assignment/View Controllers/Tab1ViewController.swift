//
//  Tab1ViewController.swift
//  IOS-Final-Assignment
//  Prinicpal Author: Edmund Leung
//  Description: A class to raise COVID-19 awareness and display image animations
//  Created by  on 4/18/21.
//

import UIKit

class Tab1ViewController: UIViewController {
    
    var fadeLayer : CALayer?
    var spinLayer : CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fadeImage = UIImage(named: "pic1.png")
        fadeLayer = CALayer.init()
        fadeLayer?.contents = fadeImage?.cgImage
        // Position the location and size of first image
        fadeLayer?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        fadeLayer?.position = CGPoint(x: 80, y: 140)
        self.view.layer.addSublayer(fadeLayer!)
        
        // Start the fading animation
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        // Start from 0 opacity
        fadeAnimation.fromValue = NSNumber.init(value: 0.0)
        // End to full opacity
        fadeAnimation.toValue = NSNumber.init(value: 1.0)
        fadeAnimation.isRemovedOnCompletion = false

        fadeAnimation.duration = 3.0
        fadeAnimation.beginTime = 1.0
        fadeAnimation.isAdditive = false

        fadeAnimation.fillMode =  CAMediaTimingFillMode.both
        // Repeat the animation forever
        fadeAnimation.repeatCount = Float.infinity
        fadeLayer?.add(fadeAnimation, forKey: nil)
        
        let spinImage = UIImage(named: "pic2.png")
        spinLayer = CALayer.init()
        spinLayer?.contents = spinImage?.cgImage
        // Position the location and size of second image
        spinLayer?.bounds = CGRect(x: 0, y: 0, width: 130, height: 130)
        spinLayer?.position = CGPoint(x: 80, y: 350)
        self.view.layer.addSublayer(spinLayer!)
               
           
        // Start the rotation animation
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        // From 0 degrees
        rotateAnimation.fromValue = 0
        // Full rotate to 360 degrees
        rotateAnimation.toValue = 2 * Double.pi
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1.0
        // Allow the animation to repeat
        rotateAnimation.repeatCount=Float.infinity
        // Attach the animation to the spinLayer
        spinLayer?.add(rotateAnimation, forKey: nil)
    }
    
}

//
//  ViewController.swift
//  ShiftR
//
//  Created by Tanaka Mudimu on 25/08/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rgbSubject: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rgbSubject.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
        let shifter = Shifter()
        
        shifter.attach { (red, green, blue) in
            self.rgbSubject.backgroundColor = UIColor(red: CGFloat(red)/CGFloat(255), green: CGFloat(green)/CGFloat(255), blue: CGFloat(blue)/CGFloat(255), alpha: 1)
        }
    }
}

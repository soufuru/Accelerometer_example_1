//
//  resultViewController.swift
//  Accelerometer_example1
//
//  Created by SoichiFurukawa on 2017/03/08.
//  Copyright © 2017年 soufuru. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var accelerationX: Double!
    var accelerationY: Double!

    @IBOutlet var labelX: UILabel!
    @IBOutlet var labelY: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var resultX: Double = fabs(100 - fabs(accelerationX*1000))
        var resultY: Double = fabs(100 - fabs(accelerationY*1000))
        
        if resultX > 100 {
            resultX = 0
        }
        
        if resultY > 100 {
            resultY = 0
        }
        
        labelX.text = String(format: "%.1f%%",resultX)
        labelY.text = String(format: "%.1f%%",resultY)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
